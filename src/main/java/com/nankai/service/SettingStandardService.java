package com.nankai.service;

import java.util.List;

public interface SettingStandardService {

	List<String> standards(int kind);

	List<String> findranges(int kind);

}
