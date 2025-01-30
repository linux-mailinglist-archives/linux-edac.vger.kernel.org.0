Return-Path: <linux-edac+bounces-2961-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D17A2349F
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jan 2025 20:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677AD7A3767
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jan 2025 19:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99221F12E4;
	Thu, 30 Jan 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="qeqcTRXL"
X-Original-To: linux-edac@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023113.outbound.protection.outlook.com [52.101.44.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED41EE002;
	Thu, 30 Jan 2025 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738264766; cv=fail; b=gf0G2kLPzBuyttnEUKp2YSKZezN5k2xDi0YEbd3ucDMHxzcclSxu/fYL9MDrHEwB2vTXPCD6DzTowDVq/rtEk/BmS8qzF1eH0j6gGKWLLL3Q8ztC5Jvf3q6zLrR3nYaJ5pwJVBmVCvSt62fO7dl3hy9rN4BODJh/uDpxJh6J3qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738264766; c=relaxed/simple;
	bh=bndT+30OuZ2OxSiHY3Ug81P6ICKi6YP0RPMn2Uoieo8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OMa2L/v4ptq5XRvVpt2XMw6wbL+xnpDh0HBsLYd325zg083NAyre+akOTit7PtsS0ZNkyPqI4Pu+GQOCCXq7OZpuEQBsrHzh95INHLKwudDlvP8XyFNc9ncp/OZHhhZJ0EXEwEO+RhikYORlv/GPlWi38ajasFjOlvemiJTLohI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=qeqcTRXL; arc=fail smtp.client-ip=52.101.44.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDhoPkBYxqZb/o9e7tZr4Q5YVtgK/5c3AWjlU8BMmGxKdwSSQd2GRvlaOJZOEKCCHLLSXOF6/QUEFtUuUN/XF/RWmEgJxybB1pJ/Rkho3ySAYu0cAJCDilXRM+2e5n1DV1WVHW7Y3wSlutw/lv+oaX3yG99pFbgpM7dg8K9KqBbpKxx+haJiRah4YdSp5fv+qXp5EIOoKr+JpsLu2uWz9yGIctPBOK6dyXSZRiR0pOREgevP+bt0rHqVSfrM3vIMSFj0e1tqVGjxlhp2R4+yD3XSfFpvclNIZXY83s1U5hfjzOWipRCzbIN53LrsmCdYmTLkE/OzstiLT3KhVPgO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bndT+30OuZ2OxSiHY3Ug81P6ICKi6YP0RPMn2Uoieo8=;
 b=I/0pJxEw+RDQKd8KAPOUX6sITmTKkAF4QsmaGxE7JHAiGKrPLdif9D14wRBgYobBVxNLjFFAHBLwL3CtFqCWVKIPoVn9/008+GtVHufQIjmMeod/5toxIXUEj0QGtxYQclakn6/AbxH6xVYy/vOGvnVTWCZWqlrZBfIT8a/PpUNqYgQArim3Q1IP+dZj76AbbX/bJdPKLVi6dotLRsFUseXKIwrk7GClFO7E/kBJE0lVk+/WFesi9HSP0sx5pD2nU+LMvRoW+jHOg+vFcHXA9Dows4b+DEtxEtEj34DawY4BU7RLXPHuVXGSWil6dj7h8V+fnwrQJbfXligtEG10IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bndT+30OuZ2OxSiHY3Ug81P6ICKi6YP0RPMn2Uoieo8=;
 b=qeqcTRXLwxurNg1rEyoWWD0LipLFNb2JsFWdu2qTF+pGF+3XFEK1BPwdEhFXvy9iAx+OVFmP+Ux2cC4oFabTXnSTFydXB7CjgumFlB8obcxaI3obms54Bz04KBOoHT7q5ip3hQbS8g32s+en/OnpI1Iq5M6ZqSb3J/gpqzDELPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 MW6PR01MB8599.prod.exchangelabs.com (2603:10b6:303:23e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.5; Thu, 30 Jan 2025 19:19:23 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%3]) with mapi id 15.20.8398.014; Thu, 30 Jan 2025
 19:19:22 +0000
Message-ID: <f635547e-ef3f-4ce5-b9b2-b9cd24a77027@os.amperecomputing.com>
Date: Thu, 30 Jan 2025 11:19:19 -0800
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [PATCH v18 06/19] ras: mem: Add memory ACPI RAS2 driver
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: bp@alien8.de, tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
 mchehab@kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
 Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
 erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
 gthelen@google.com, wschwartz@amperecomputing.com,
 dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
 nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-7-shiju.jose@huawei.com>
Content-Language: en-US
In-Reply-To: <20250106121017.1620-7-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|MW6PR01MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: eca0d29a-2250-4656-15d1-08dd416300ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0F6cWlPR1VoQVcybzV5SHhLRk5odTJIUytLYytqai9rQk9keFZVbUNZSnll?=
 =?utf-8?B?RFRKUG1yL0VVVk55NEdQZ21tQnhwcXp2VWUzdjdOR0pOMGlkVHpoREZxWm90?=
 =?utf-8?B?dUk5TnpvQlNja0FLdFRNM3lJVGcvLzhoM2pINzRzUjFIa0NrdFc2N2hBWTFX?=
 =?utf-8?B?QVF6eXU5aEdTN05DMEE2bjR5NHo5K0RFcklpczkwNmhNY1phMitOYkdiMXBq?=
 =?utf-8?B?aHFNOUcxRlpvUmEwMjNLN1ZoeHJyM1RyNjVtV1llVW53dWo2MmdXbnU2M21Q?=
 =?utf-8?B?cFRidXdMLzVGVitrbjlTb2k5bGlxc0k0ek9xMHZCS3gyeEE4ZnZBVEJ4c0Q5?=
 =?utf-8?B?eE1hVlgvMWpQaXFCRFJ2RnRaZWFkWTVFVlJpK1AxREQyeTg1bmY5eGE4SlNv?=
 =?utf-8?B?bnFtMlFCMDNLVUZFS1ZqTTB6dlYwSGlGbjV5dnRBNzJrRlU5RERwNkJLdDV4?=
 =?utf-8?B?R1VoeXdHblNNdWt2UUJySVlEMHpmSzZHOUhOdmlPY29qdUZkY3RtVExkS2Fj?=
 =?utf-8?B?S3FnWXJvNXJRQXlEQXpXWmtITEE5cU8ySld5YjRiR0VpekRTOXVSOUJ6Tmx3?=
 =?utf-8?B?L3dLbmpGaHVqZ25ranI2MjNnWk9FdU1TY0paMTJqTkRlN3FiU0s5N2Nob2oy?=
 =?utf-8?B?eHJSeUlqNnptUDN2djlwNC8rVzYxOURhTmc5VDg2QmQrU1VkWWhBTnAzVHFF?=
 =?utf-8?B?bTJIejIxM1VSQXk0eU9KSUV2NldzZGEyalhqK3Q1aUN4RzBqeEljV2Fmc09q?=
 =?utf-8?B?b1lLSEFDSEF2dFVBT2h5VUJqVDlzTEJhQ2tUelBRWlU2TGh1cTZlT0dmU3Zn?=
 =?utf-8?B?UVRhdFlIcDlzRlFxNWliL1ZHS00rNFlTNzFDSmNHNkFmVE5UMHd4SUtwQW1r?=
 =?utf-8?B?Sm1Ub3JZcWxyRkpOMVBNRUt4WFFYZFcvTzBYRUpDZWxkOHFXalhFb2NaTUx4?=
 =?utf-8?B?NXQ4S1pYNndUekhNK1NiZVhRZVFkcEdJVm1DbUw1RjQyVU1uMFM1WnJQTjFj?=
 =?utf-8?B?NG9xZEF0RERjYXRvSXBaQmtwNVFjNXo2MlpQSUhXMHZLRHp6SCtvU3JEbXFB?=
 =?utf-8?B?K2lTZGpuKzl6NFQ1TGw4VEpxbHMxWGdEazUzRlNXUU1uK2tRM21zZ01zdTRY?=
 =?utf-8?B?ZUJIZXd1NVZ4SEh3b2lYekZlWGcyZWFCSXhyMWxuYTNSa2N2ZWcxTHZqblY4?=
 =?utf-8?B?R0RNZHNZQzgwMWVTT0l0dWFRY0Q1Z1d6ajZuY0F0RE0wUjNYQ1VFUUk1OTE0?=
 =?utf-8?B?clNVVUdxeDZYK2N2WENXbWhvVkpiTDVva2xBY1VpNmFKY0YvMDNrZFl2N2hy?=
 =?utf-8?B?UHVsV2lVL05iRXU2eXliWjVOaHBTa1N5U1dNb3d6ME1QY213Qmw2eFAyaXYv?=
 =?utf-8?B?a1lQOTErY3RWZ1BCNzVRNkI3aGFBVGZIRXFjUXRlK05nb29PbjlPZ1A1Ny9l?=
 =?utf-8?B?WVUzRW9xOEYraHcyQmRHUk55cUVrcnF6S2NGWjVCR29nSjJJSTdLU2VaZDJT?=
 =?utf-8?B?WVhvZjVBcGNuOHgrYUFrNG14OEIrT1dOdDFGcTZVTGNJWHE1YUY4SzhwME5C?=
 =?utf-8?B?SUhISGRzWXIwQUZldjJlWVo0a1pjMlZyZnEvS3FxWWtMMS9Kd09LbDh1S1Vy?=
 =?utf-8?B?UmNrVWk3N0x0dkdwWGo5NTFlQzdyMlM3aitjOUxpN3VkUERxbzdSY0pGellC?=
 =?utf-8?B?Z29iQStqTEtMTEhZK0dUcnFHdWtYaTlIb1N0bGRwemREaDhCc3hJdUcxME42?=
 =?utf-8?B?OVdWMHdvdithdElDSUxEUGY3b1o1TU9ST005VHRtcW1VK0h1enpXTGQwNDA4?=
 =?utf-8?B?TGc2YTV5YlpUdEVta0EzYWVHTjg4dlZLckViamgxcDkrNTBQaGdHV09mUk9R?=
 =?utf-8?B?SWVqbUFOMU1YRm1odXBtcm10SHg1NEhzaXhMck5Jd0xIcU9nMGVxeTFONlhD?=
 =?utf-8?Q?wOTSGKicQUjuiZmVDBdvluYbQfWT082S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU0yTTlrdUszTUMwNmFwU3FaSHNiOEVHU2ErM0htRHVaNUtEOFFFbTF6VXh3?=
 =?utf-8?B?R0EvMkRXWURxQ2VUQk9FTXkwbXYxU3BKWmxJY2JWamdXcG5QMFAralZCVVFl?=
 =?utf-8?B?RTRnVUZxVW5GTjZYN0hJOWw0eXRubURTdTJIOWdZd3NzWERGQnhCcitxTExV?=
 =?utf-8?B?amxCMlVEY29VRVRsdUxnQnhJTWpUREFNWDJ5YUNyaWFOSGo0SEVhSGdhTFJB?=
 =?utf-8?B?cjNsNk9QeXU0eWF4dG5KNUZnU2k4b1I3dlV1b2JkeGQ1cU4ydjZnOFluanJC?=
 =?utf-8?B?OU5EdG9jYXJybDh6cDd6UkFLRHc5d1BNbVR1dWFxL29jKzZ1eXloVEpPZWRz?=
 =?utf-8?B?ZlNRVkNrcjhmdWNUVzBYaW9OSVhBK1F5cjl3Q2xoWVlZN0puZG5PbjAzc1dD?=
 =?utf-8?B?enJhelBVTWllL25vV2RQekNlUVVWQzFoRDhTL0NUZnZVV0NqMmJXYzZuVDA2?=
 =?utf-8?B?SWxNdTFzU1BLZlA4QXpmdzlaQkFTV25uNU52dkFwZXlIZ0c4RFprelJnYW44?=
 =?utf-8?B?bktSOEtSclYzZlIzb2xEWXBZcEEvZWV1emFsOGczWU5BVGF1QmF4dEc5MG5U?=
 =?utf-8?B?c2E1UzB4QXBUYXdSeElvWjFsMHRDQ0NPUi9ubC9RZ1hnZFNJMGZydi83ekJJ?=
 =?utf-8?B?ZEo3OUVUSjRSUjZOZ3R3UnhqSzBnYWN0N2FDZk9rbTFvTTIxZG5oV1o1dWdY?=
 =?utf-8?B?M1JrUkM3Q2VHdHgxQ1NOZXpYbHljaUlaeGdUZjd1Ly9COW1YdCthanpuaVFt?=
 =?utf-8?B?b1pLanVLMDdmclE1cHVudmtZSno0R2NwbUdCUWVJMEVuT0t6amVrazVsN2lB?=
 =?utf-8?B?UytPYXB0ZGhJaElUcmJyRVFYVUFWQlo3NGJNUXhsZUhuNm5reGRZN2NRUU9O?=
 =?utf-8?B?dmlrZitvWkN6dFJlNmMwTEFmYzZ0SkZYVDRsV2NPTmlYdk4zTEN0TnU5K1dr?=
 =?utf-8?B?U2xnZm5QcTBLZmtIN2RucmdiNTA3SnVpbjY4NWFMTkJiY2M0TEdYUm5KV05v?=
 =?utf-8?B?VldZdkI3Ni9hSGRXUndsYTlQUko1RVVVUWVzVEhTbVdjZG44V0pWMVVkUnVs?=
 =?utf-8?B?a2ZmWlN2TUh5MWI1U1gwdUFBTGNKelNibkNzTUpIMWNLOVlQVFp3SlpWNDZI?=
 =?utf-8?B?Z2dpVCtmd25nVXRXbFFUK0NBSWVnU0Qrc1RoZjhTaVFYRVNjRHdQNHpCMUxv?=
 =?utf-8?B?QUdKNkpISHFoUzdKVHNyZzVUc1JIelhEQmQwUllmdllqOUJhY0toYURrbTM4?=
 =?utf-8?B?L3YrTnVtdG56eGQ3eTRSRG1PRTM4U1BsaEJ2ai9acktlcnJ6SVRaZE5KV0p1?=
 =?utf-8?B?RjJUNGZ0STc2aTlrMURIdmhCUlgvUmFYU1o2SWhvN280VWpteW11VDArRkN1?=
 =?utf-8?B?ZEg1UzlSMDZoZzh4RWRqeWgvRkRiRkVVUmNhcXY4dXV0dVlNUHhRMkUwYjRj?=
 =?utf-8?B?ZTFCWThUbTA2djhXQmI1dzNjU2UxOWtwU09vVEtrQ2pOc01TelV3N3VEaU5F?=
 =?utf-8?B?bWVMYjdlMXVGWTExRm1IK25aK0hrdUhjWUxpc1UrWFZkSDBHVEw0UllMZ0RX?=
 =?utf-8?B?OXE2SWNVejdWVlFKbUltK1ZLcU9ISnR1ZkVpeFlwNjJNaXQ1Szk5dHQ4MmdM?=
 =?utf-8?B?eEhZUFVYaU5NdUVhdkN1b3hVZTNXdUZiaVNsSjRyUXJCaUU1TDJQSzJYMEY0?=
 =?utf-8?B?ZWRZLzEzTlI5YmEwN1FLNEcvSy95NWtXS1d2cjZWODVrcUlTaUxxRVAwZ1Br?=
 =?utf-8?B?NVZ6L3kxV2lRVWh5eC8vWGZKWkJuSzVGYUJLOGVQYlVqNlVHWEc2Ny9pUnVR?=
 =?utf-8?B?Y1IrdTBjOG8vYXhXcUV4eG93WWdOTzg1MWE5ajBBS0xtWU5IWnZDYU1HZ21o?=
 =?utf-8?B?cmdCNEphaGZJOGV4ZDg5U3g0WVJ6RVc0VldDTTBiQkQ2WjIvb2JBUUx1dzRj?=
 =?utf-8?B?N2c4MktrMVZOVG9WNjJkYk53OG9FY3dTRzJpRnhCWFprVmRELzU4NXJKRTRa?=
 =?utf-8?B?N2VoRzJCQjhQL2QvcTJXdHMzaTdreFFQM2dUN1NxWlo1R1NuUHNmSTlENHow?=
 =?utf-8?B?N2JIQ3NPaXRtVG1nZ0hnTmdwR0RTajB1cG1DcUU2bzJLNGlFbGtkbzlNeFp4?=
 =?utf-8?B?ZXBnTDUzaFJjRGhmNEgwMEhlZUZGeE5DSEdyMExQbTNzSU5aSjROZVpseEta?=
 =?utf-8?Q?11dwXvjueOY5iUffCvT5Tqg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca0d29a-2250-4656-15d1-08dd416300ca
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 19:19:22.8343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRvtD2DL1mtaa7UZeJARQ0DomcoQfFBKW5WD8t4v4xZixFBGv3b+ZH3kOjZxDl/prC25QSxn/q3h4mJBZECg3TrFjyEdXJTN0ybh5vpiWE9laisHrVqKcZLIy1WBdRb5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8599

Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com> # arm64


