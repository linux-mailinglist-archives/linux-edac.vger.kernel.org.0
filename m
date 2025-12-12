Return-Path: <linux-edac+bounces-5570-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0259CB9258
	for <lists+linux-edac@lfdr.de>; Fri, 12 Dec 2025 16:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5903C3005E8A
	for <lists+linux-edac@lfdr.de>; Fri, 12 Dec 2025 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62171ACEDF;
	Fri, 12 Dec 2025 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpBkZyMU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA249277819
	for <linux-edac@vger.kernel.org>; Fri, 12 Dec 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553321; cv=none; b=GOMrSq/e5ZnJ53wlJGTYFYHeQ5uIB6zeiChO2rfmvLBjBjvhVi9Y2mOIUasMLRASpl5tbDjb8c9dFCjMrxJMgPPXULD8w6EJB2NNB5jvM7ENRilXO/kg0FEFXLI0MlNSdPQBrbbwuV89U5KFE23lt60nUS5PxaCJrxF/BY1MEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553321; c=relaxed/simple;
	bh=gJ90wkMhR8Qj5085s7CPcgymRJNj72ogLyr+XDoHOnc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=afhtIYdQzf6qSFBqJTg2oMXCorZFTyWif3rpWEKx5HYdzYqxt6K6np/n72KvqW857gCslVCU59TFuGcg5Fs9u8czgDsfNbhPfFtuPb0wBUVPU18yZiCo9OKDjTDGNzev+zA2kIVSeflPplJ/vtgGF9h7B9mNjKJE5xyJQt5/pbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpBkZyMU; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-644798bb299so1083966d50.3
        for <linux-edac@vger.kernel.org>; Fri, 12 Dec 2025 07:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765553318; x=1766158118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gJ90wkMhR8Qj5085s7CPcgymRJNj72ogLyr+XDoHOnc=;
        b=gpBkZyMUNC/X+vlnMsIh0of49dXwe2p4SzNIinxhDtolzEgVLqd5ctdm7e/yKNJEHq
         HFEIMEeGRV1/qZr2CR4E25iEvoPSwFemoAIeLrECrPZHLQNqACbBsODaYTuuKHE2NjRc
         a/0RxjYgTLCB8MIR7ZL794dTvlc2ARd+P4rIvJiVg1QijQfFlVt8fhkYa9/sgsosREVO
         8UdMNzAKcCje5CxSPcWk+4JsouxB0PF5LbuyRBBLJTDPpNqDYMbTY/wbHziHile+eSPJ
         8a0q8Gq74KAsTE55kDX9sfyg7RNM7SmGz/ryBvWa3r8RS1bvDWAKK/kDMSMjTJZB3Fb9
         HxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553318; x=1766158118;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ90wkMhR8Qj5085s7CPcgymRJNj72ogLyr+XDoHOnc=;
        b=tMkh++MWyvSXySAce/kSogiGef0rH95TozNnbCxzVaWiVCDDviv6RQJehwCYxy5QZ2
         +MnQV6dr6YkeHDlz0wgyraF/U6TYLsfXWQb234jm6rP7As6h47ZWOpGgD/n5zbOf9kkD
         Ix8OPxCPdMcULCa3xespJo7Q00NgoPuG3FAGPDkR+FCZHFqL9Lg7u2+EwUAiZGpEy2ll
         0WwHjH7Vl/4m2u8StEimFJcn68FFzm+Guu5ZIS+2jtjBcfH4pXf4c3CySSxC9ebxI5NF
         2Y+Rt9AodPhYMpsO6FO5WlRxhKY7O0BMe2SWhkDWQLusPXHH9jqY6K9LehhuS3xLU+oF
         W9Rw==
X-Gm-Message-State: AOJu0Yz/KCiq10C+acr0bp7gOhhWBF2lFNU1gJMwvteFwMcKG3T662KT
	Iw8O/DjOUz7mlCn2I1BdiKXeensWQVy8nLHMHhjki5+QSHp8PxCU8+PAmHslNPh6VfcMTaOixPN
	Z4Xc7m8cnoQDYditGLcSJtVTSxKphWyp+tToi
X-Gm-Gg: AY/fxX58KNRKXjCuREQVbhKPrHjsCJWnQM7MatcM+AJ8rRTlLpnAJN8JVkj4hJx0IZM
	NAmspoMyPTiE6t/N6owbf+4QEgnvsYpuLZCcrctLolFMc5XN4Yjqi09M9UAeLe5szRX/3eMlYNI
	5YRibb1m527UFFlLWqQ/grtoy45dLCSkCaCPyaVFFGoyYKltqDanwe0MQml94Xcwzei3bXzgD9F
	eEtGot7lGTtwwjeocdtRDc3M/jb8w/DI3N88I+K+EfqJEMR/1IGE4+ZkOjTcRi61phYtr+p
X-Google-Smtp-Source: AGHT+IGfwqchZdai9VHt+wFJABw4adF03Tv3w+c1eGT/qVYESIRP/74n5menXIQW1ADIf/9Cinr9ffH4pvxpTKUi+ho=
X-Received: by 2002:a05:690e:189e:b0:63f:c816:1171 with SMTP id
 956f58d0204a3-645555cdbd7mr1755793d50.13.1765553318456; Fri, 12 Dec 2025
 07:28:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kegl Rohit <keglrohit@gmail.com>
Date: Fri, 12 Dec 2025 16:28:26 +0100
X-Gm-Features: AQt7F2pODhYe3h61gwrjceJ9ZtXRVn2E4YdPEQ0QGK9RnYzX_SqHcsElPY5JvmA
Message-ID: <CAMeyCbi-RmWAd7ehYSurr7bgiyT2O-OEJG1_Dv-pKnXdQ97eWw@mail.gmail.com>
Subject: [Question] EDAC support for Intel Arrow Lake-S (W880) with ECC UDIMMs
To: linux-edac@vger.kernel.org
Cc: tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello!

Looks like Arrow Lake-S is not supported in ie31200_edac yet?

ubuntu@ubuntu:~$ sudo modprobe ie31200_edac
modprobe: ERROR: could not insert 'ie31200_edac': No such device

ubuntu@ubuntu:~$ uname -mr
6.17.0-5-generic x86_64

ubuntu@ubuntu:~$ sudo lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation Device [8086:7d1b] (rev 01)
00:02.0 VGA compatible controller [0300]: Intel Corporation Arrow
Lake-S [Intel Graphics] [8086:7d67] (rev 06)
00:04.0 Signal processing controller [1180]: Intel Corporation Device
[8086:ad03] (rev 01)
00:06.0 PCI bridge [0604]: Intel Corporation Device [8086:ae4d] (rev 10)
00:07.0 PCI bridge [0604]: Intel Corporation Meteor Lake-P Thunderbolt
4 PCI Express Root Port #0 [8086:7ec4] (rev 10)
00:07.1 PCI bridge [0604]: Intel Corporation Meteor Lake-P Thunderbolt
4 PCI Express Root Port #1 [8086:7ec5] (rev 10)
00:08.0 System peripheral [0880]: Intel Corporation Device [8086:ae4c] (rev 10)
00:0a.0 Signal processing controller [1180]: Intel Corporation Device
[8086:ad0d] (rev 01)
00:0b.0 Processing accelerators [1200]: Intel Corporation Arrow Lake
NPU [8086:ad1d] (rev 01)
00:0d.0 USB controller [0c03]: Intel Corporation Meteor Lake-P
Thunderbolt 4 USB Controller [8086:7ec0] (rev 10)
00:0d.2 USB controller [0c03]: Intel Corporation Meteor Lake-P
Thunderbolt 4 NHI #0 [8086:7ec2] (rev 10)
00:14.0 RAM memory [0500]: Intel Corporation Device [8086:ae7f] (rev 10)
00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:ae0d] (rev 10)
00:1f.5 Serial bus controller [0c80]: Intel Corporation Device
[8086:ae23] (rev 10)
80:14.0 USB controller [0c03]: Intel Corporation Device [8086:7f6e] (rev 10)
80:14.5 Non-VGA unclassified device [0000]: Intel Corporation Device
[8086:7f2f] (rev 10)
80:15.0 Serial bus controller [0c80]: Intel Corporation Device
[8086:7f4c] (rev 10)
80:15.2 Serial bus controller [0c80]: Intel Corporation Device
[8086:7f4e] (rev 10)
80:15.3 Serial bus controller [0c80]: Intel Corporation Device
[8086:7f4f] (rev 10)
80:16.0 Communication controller [0780]: Intel Corporation Device
[8086:7f68] (rev 10)
80:16.3 Serial controller [0700]: Intel Corporation Device [8086:7f6b] (rev 10)
80:17.0 SATA controller [0106]: Intel Corporation Device [8086:7f62] (rev 10)
80:1b.0 PCI bridge [0604]: Intel Corporation Device [8086:7f40] (rev 10)
80:1b.4 PCI bridge [0604]: Intel Corporation Device [8086:7f44] (rev 10)
80:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:7f38] (rev 10)
80:1c.4 PCI bridge [0604]: Intel Corporation Device [8086:7f3c] (rev 10)
80:1c.6 PCI bridge [0604]: Intel Corporation Device [8086:7f3e] (rev 10)
80:1d.0 PCI bridge [0604]: Intel Corporation Device [8086:7f30] (rev 10)
80:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:7f08] (rev 10)
80:1f.3 Audio device [0403]: Intel Corporation Device [8086:7f50] (rev 10)
80:1f.4 SMBus [0c05]: Intel Corporation Device [8086:7f23] (rev 10)
80:1f.5 Serial bus controller [0c80]: Intel Corporation Device
[8086:7f24] (rev 10)
82:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co
Ltd NVMe SSD Controller S4LV008[Pascal] [144d:a80c]
84:00.0 Ethernet controller [0200]: Intel Corporation Ethernet
Controller I226-LM [8086:125b] (rev 04)
85:00.0 Ethernet controller [0200]: Intel Corporation Ethernet
Controller I226-LM [8086:125b] (rev 04)

ubuntu@ubuntu:~$ sudo dmidecode -t memory
# dmidecode 3.6
Getting SMBIOS data from sysfs.
SMBIOS 3.8.0 present.
# SMBIOS implementations newer than version 3.7.0 are not
# fully supported by this version of dmidecode.

Handle 0x000E, DMI type 16, 23 bytes
Physical Memory Array
Location: System Board Or Motherboard
Use: System Memory
Error Correction Type: Single-bit ECC
Maximum Capacity: 128 GB
Error Information Handle: Not Provided
Number Of Devices: 4

Handle 0x000F, DMI type 17, 100 bytes
Memory Device
Array Handle: 0x000E
Error Information Handle: Not Provided
Total Width: Unknown
Data Width: Unknown
Size: No Module Installed
Form Factor: Unknown
Set: None
Locator: Controller0-ChannelA-DIMM0
Bank Locator: BANK 0
Type: Unknown
Type Detail: None

Handle 0x0010, DMI type 17, 100 bytes
Memory Device
Array Handle: 0x000E
Error Information Handle: Not Provided
Total Width: Unknown
Data Width: Unknown
Size: No Module Installed
Form Factor: Unknown
Set: None
Locator: Controller0-ChannelA-DIMM1
Bank Locator: BANK 0
Type: Unknown
Type Detail: None

Handle 0x0011, DMI type 17, 100 bytes
Memory Device
Array Handle: 0x000E
Error Information Handle: Not Provided
Total Width: Unknown
Data Width: Unknown
Size: No Module Installed
Form Factor: Unknown
Set: None
Locator: Controller0-ChannelB-DIMM0
Bank Locator: BANK 1
Type: Unknown
Type Detail: None

Handle 0x0012, DMI type 17, 100 bytes
Memory Device
Array Handle: 0x000E
Error Information Handle: Not Provided
Total Width: 80 bits
Data Width: 64 bits
Size: 32 GB
Form Factor: DIMM
Set: None
Locator: Controller0-ChannelB-DIMM1
Bank Locator: BANK 1
Type: DDR5
Type Detail: Synchronous
Speed: 5600 MT/s
Rank: 2
Configured Memory Speed: 5600 MT/s
Minimum Voltage: 1.1 V
Maximum Voltage: 1.1 V
Configured Voltage: 1.1 V
Memory Technology: DRAM
Memory Operating Mode Capability: Volatile memory
Firmware Version: Not Specified
Module Manufacturer ID: Bank 4, Hex 0x94
Module Product ID: Unknown
Memory Subsystem Controller Manufacturer ID: Unknown
Memory Subsystem Controller Product ID: Unknown
Non-Volatile Size: None
Volatile Size: 32 GB
Cache Size: None
Logical Size: None
PMIC0 Manufacturer ID: Unknown
PMIC0 Device Type: Not Installed
RCD Manufacturer ID: Unknown
RCD Device Type: Not Installed

