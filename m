Return-Path: <linux-edac+bounces-3345-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB676A5B69F
	for <lists+linux-edac@lfdr.de>; Tue, 11 Mar 2025 03:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9220D3A8865
	for <lists+linux-edac@lfdr.de>; Tue, 11 Mar 2025 02:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2572E1E32D9;
	Tue, 11 Mar 2025 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OoDg8jnp"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C9615820C;
	Tue, 11 Mar 2025 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741659745; cv=fail; b=CCyz+6l3y5t6ROv+1WNOjMV9Xp0TJI8LV8SgdJP0Q3yPhoEkY6AuZWKxtfPqIK1pm/MyghzQ+XodgbKIpmlGMW5viLGF6Cm+urB8LV9Cb1aYkqExpWzimuSu1HLAUqyUyvp1X5bsLWTGWDEx27GOsVT4nbg/KEtj0mlBVe1EoNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741659745; c=relaxed/simple;
	bh=jW+8bGwFEBNI2ErYtM1amHQcoJz1mNVXojZQQPxQnts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y5tURXE6lLH0O4+WKwLQBWqPdJyC0DmCTQAqmDkPgTWzgm48K3kmvMGj8M7Pt2DMs2nbbq+7taMnpX5OCAEaivi+pEcBiRw0X4p6x74VIBfz5X+3UbulS4DVVQBzqH9IvZFqanbO53D1Gf7D3l3ZFc0FBekgsIVdccM8euLEbJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OoDg8jnp; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVMNw5T/BirWtLNI0ZeSBHTzF7l/hSUdScfjo5faziF65LmPdgrTk35IRPrL/8xCKeJYioZMSxSITcNX7IeP+ognQ7dfkHgZBVP6kTwQtCkZfLQv/3o9GSO6t0Abjmd5GDZCpJPLNOYVUh6OAO08zrhtiW1uhjhMXvCvKL5iOnCWOu5IrGJ9lbtQdrqrzggTfUfG0pI5wBf12ElwMoqxG7GrwEf2te7JkOu3gQ58neh1yPfh8i2byks0PhJA255Yjv62RTAc9bDvqqjWW2PNJNBLsjTNErFu4hLyV1nOyXx06ll/V/MN1OTuhTRRIxe/X34sDiIUtY2reLB7hVqnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jW+8bGwFEBNI2ErYtM1amHQcoJz1mNVXojZQQPxQnts=;
 b=ndiOb99nHPtUBUJQm3JNyLw70u4VuC0nTCvvP0lRPaPViJq0Maa5bvMQzWmCeQZOqeWiaYlFoOuAlQcPEfutO/EyWp5ssR+FZOV1B/lHWm3IluBggDf6JTACDsKKiAIIT2ornCY7k83IV3bHIoVJcmWTv6gt5ALFxl/BNyiJV5LjdlEcHpgJEa/wHfJQtJMQZBCZLS2SZJfK/JxYGtp4+L0LLrUpAyo6l9l853AeDZtpiQ+aELbVDUiZL8nTs/2L4T5T2yz35BOvcIDE02p9LAOmN2fVONoFlGTtiJZHOx4ErP/mLDTa+Ov6tg5917UgE401IiTkdSs5erYJD6THSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW+8bGwFEBNI2ErYtM1amHQcoJz1mNVXojZQQPxQnts=;
 b=OoDg8jnpwdaib/7rKkcsQRUSd6TlOGOMLcdeae+WMIzK9ZXdVTDg8F20BnnpZ5JNCbIqoExJrDbxTkKqoDp2L1VGuc2AQaHs8NwnlG4di+c5JGYJorZq3FFEc+crmqlq5rQ5IczXx+l/eukIdKQqet5U9s5bJchcOi3inPuUlfV7kCcCquEBlbUNPdRg9yU8b69xI70REmYc0FMHiiMXdjQRkUP49LRlfYjYbTSJ2WullqShfVMjWb4D7AZ1SAhgpxlKZ57OnHJ3AjM2en+IxJOZZEiiPLEZyMuKS/XyojqZHij7sm/9n2KIwNdcagu/7ZcCiK/a02eKEbYUoFG41w==
Received: from PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.26; Tue, 11 Mar 2025 02:22:20 +0000
Received: from PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0]) by PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 02:22:20 +0000
From: David Thompson <davthompson@nvidia.com>
To: Borislav Petkov <bp@alien8.de>, Dan Carpenter <dan.carpenter@linaro.org>
CC: Shravan Ramani <shravankr@nvidia.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: [bug report] EDAC, mellanox: Add ECC support for BlueField DDR4
Thread-Topic: [bug report] EDAC, mellanox: Add ECC support for BlueField DDR4
Thread-Index: AQHbjEvvRVnMwoN/OEGALHJH0b49J7NtPjSw
Date: Tue, 11 Mar 2025 02:22:20 +0000
Message-ID:
 <PH7PR12MB590225F9E7C1BA48B5EF538AC7D12@PH7PR12MB5902.namprd12.prod.outlook.com>
References: <046bf689-9a2b-4993-b8ca-927d7d2a0cc5@stanley.mountain>
 <20250303145226.GCZ8XCKkC0YSLHXycB@fat_crate.local>
In-Reply-To: <20250303145226.GCZ8XCKkC0YSLHXycB@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5902:EE_|DM4PR12MB6472:EE_
x-ms-office365-filtering-correlation-id: 22df32a3-496b-4f4c-cc05-08dd60438d05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUUySFE4N2ZnMERVUGhnY1k4aTgyQkM4MnoyN2g5YmRucER6MnA0bjhKK01C?=
 =?utf-8?B?NXJvelhPTHY3QzFkbDZ2WWJyUXVYM3E5eU9sQ2tWc0h4WlB1TDFjdHhKenkw?=
 =?utf-8?B?K0ZycERuZFJGeFRobzA4STBYdUFNZ0JEazVnaEhFZXNNeWhrQVJnVGFlTXNs?=
 =?utf-8?B?cGZudDhtbWZrN3ljejVDRjZtN1lvMTlHN3J3ajJuaGtJa3RYN29CRUJndGdq?=
 =?utf-8?B?ays1S3NYU0pEVzRYcytUdGZJcXJFdzJ5b011TjI4T2pRb1Ixd0NKNFk3dTNC?=
 =?utf-8?B?c2MvaytyTGlMQXRUbTNVL3p6Z0VpSHp4MGw3MHdDUW14QjQ5WWZHZXBKTlFn?=
 =?utf-8?B?ZHhTZ2syMUJFZWdxRFpnaTVXdXhEM0pYWTE1QzlacmVBOXZJV1Y3bEk1Ly9G?=
 =?utf-8?B?SHhScXUvQnZyZC9jb21FM3lCV1BKOEpiZXVNb1BXV3Q5Y0ZlR20xYU9aU29N?=
 =?utf-8?B?SE5KZ2tZNmRVWE91RVpSbHY4Rm00MU04eWl3d2Z1b3M4bTM0aGEybUpxK2s0?=
 =?utf-8?B?NnBVTHhLcEpXYytUbHRBYnJyelpFcSttdDlUUHNaOHBLSzE4aFdyMUc2bUZM?=
 =?utf-8?B?a1hIdGdGckZuZzM1clVBdkJhdCt1Y0RxVHlCZC9CSTVBWVpaZ09IMzIyUkxB?=
 =?utf-8?B?QW9PTFQ3elk2KzRuV01COHpqK3d2WVRwZXhGeEJQRG5JdThQWmh0WHpobURj?=
 =?utf-8?B?c2diYnBleC9Ia0lYZVUveEVDUFgvOCtjOVlrcmJRMmd3dE9tcis2dmRVZlU3?=
 =?utf-8?B?NlRvNkx5M1crb25sUEpSVC9tWXNvTktVaGMzbXFveHo4ejFzejZtdy82dm9h?=
 =?utf-8?B?VHplQlNBRjB1MTQwZ1pZdUlCRVVudGdzdXRkRW9IT3FSREx4L29RRnc1Q3dr?=
 =?utf-8?B?YVFJNUt5dENHNWlReXpWdGJQcXBzQkc0Vk5GM2IwWDFwKy9RNmZqRTN1Si9L?=
 =?utf-8?B?MTlDYjIwVnQxVUNYZTZDbkpyclhQQ3l4T0I3TjJvYlp5bVpxQTNlRlY2bjZ4?=
 =?utf-8?B?VVJBMlBkdzdkV1VQNnd3cjhBT016cDV2cFNUZEpmRFByMmNOZXJ4dGhPdWJG?=
 =?utf-8?B?bUVZdmc1T0hlTG81QlFQYnFQWjVGYXNGSGNGTUpWejJOb002b0YwaHo1Smk3?=
 =?utf-8?B?NGFlbC9ydDFEVmRSL2NtY0k0M05KK29rN1VySWxESWVsT1JQS2EzaVJ3dWRD?=
 =?utf-8?B?YXg0aXMvZFFLYlV3SjRuZlRqU2JNcXlaaENVbk02OVM1Y1N3dFdjekMvazFz?=
 =?utf-8?B?UmgzSlBldDE3R290bnFXVzhJd1c4U0F6aUVGb0R3cjhtdVA3bSs2eWlDUkh6?=
 =?utf-8?B?cm96aDFMZGhFNXVkMWZ0TTlCakpCak5tTm4wbVh6RUtrN2VnZCtxMmpaRkUz?=
 =?utf-8?B?VmZtN2FZdTFVcEU1Z2Z0bkVRengvNm90K1Z3c3lvYjZ3bENFR2dLQWo0cXFa?=
 =?utf-8?B?OUd4Z0hsK3haTG1yTWpUQ3FTdUJFaWxKRTQ2ckpZQjRUZkhtK3RhemRIdU50?=
 =?utf-8?B?L0pSRHhUN1ErUk5YWmlVWXJ0cnhnbFRGaTdJWUtLS0thaXZEb1dKdEhKRzZw?=
 =?utf-8?B?OVhHUmZTZ2ljdVc0a0xabEhLOFNoNEw1amtBbjFDa2ZsRmdpcFI5dUE3ZmFV?=
 =?utf-8?B?YXh2UExKbWMyT0pjMzJUN1dTUGlydHp5TFhFWDRFV2dzMEh2eUh6UVp4azhT?=
 =?utf-8?B?dEQwK0kwZTFUOTJobWVMcWdiRUZMVG5sVUdUYnczbVNYMklwMHVJc2dlaE4r?=
 =?utf-8?B?NXZEVkovS3ZKTHpJR3YwMDBmNElDVll2RThVTjQ2VC9SUld4a2cycW1xUzN6?=
 =?utf-8?B?WngvdW1IZ20vekR4TVhHVlhxSU5NTXE0OHJHRitsMWJEVmdIaVBFOUpQb1V3?=
 =?utf-8?B?NFhQajRUYTZBNXNtYmxkWWNSbXc1L2xkYzZZSTlyckRORyt5dmNkbkZYN3JV?=
 =?utf-8?Q?uorSfmcqf31zTjClV3eCM+ZkxGjdMBKt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnczVDZ4RXJLS055ZTE4ai93Y3RpMlQrbklvcU1ETEZFaGdWWk45L1NQVHhK?=
 =?utf-8?B?bDN5MGpFR3ZMeS85Mk5lcm5IdFpHT2EveGQwRzJCTERUYXJ3c1g0ZG9Xd2xU?=
 =?utf-8?B?c2tqTXZKSmhQdjNZQVB0UHNaTGJzTFVrRHZrdklPdjVmbEdOU095VkZIcnJ5?=
 =?utf-8?B?bmxlV0hoODV6Qml6WjZzNEc0WTdpaThuUWl1VVJwSVhoMTM4WTFvYjIwYXk2?=
 =?utf-8?B?TWpHdkhOZ1RNaS9PcjlGNHVSVHN6aGExRVIrQ0ZhVlVaWUM4U1kwWGswcmRx?=
 =?utf-8?B?OHZwTEFYamI4V1RoQ1VYOW1KcEtEUURQUUdNb3FWK2pneW1EOUgvY0tiZVBz?=
 =?utf-8?B?aEFtUnBXVVpPLzBCR0diNFk5cmVaWVNKYm4wUEtQVlZ4Vk5LdVhJaTlnd2NQ?=
 =?utf-8?B?MHk1bzNqVDRMblZJREJXOG9HQndwWWJYZnZsRWdVSXNkN3FOdjFqYXNDa0Jy?=
 =?utf-8?B?a0tZL2VmMUlsd05rWHhTMlkyaG1hM0pkcElTZWQxdzNiaDlYQnUvK1NsVmdu?=
 =?utf-8?B?ZDA1Rldtb2MxVFl0MjcrWUY4clpuUmk1NTNxWi9ERjJtWmhlNlRKRlR1bmdp?=
 =?utf-8?B?OUVmczBTZ0lpTjEzODAwWGp4bGhNZndkUzlvMjRrSW51T3RlWGpaa3MrbXd1?=
 =?utf-8?B?bllma3QzY2poR2ZENHBFWDJuR2NCc3NYN0NLcWZXV1hTb2JLTHIwdHVxbVZJ?=
 =?utf-8?B?V3RiRUpkd25JTUpwUU1iUjRwV240RHBJM1V5bWRCZzBuc3d2RDF5OVk5NnEw?=
 =?utf-8?B?N3VYazNpU3RoempSWWxuazlTbXBsYUhUOXlhd2syeGRJY0tnamNFaVpmV2dl?=
 =?utf-8?B?Vm5xb0F6M2JReElTNnlKeERLS0ZsTHhKWCtjeEg3NERhcmZCb2dtblQwNE1q?=
 =?utf-8?B?aEJ0WDUwZy9XY3habllSaTRvL2NiZXg4WlQvV2s0YnRjNWx6R3U0TUxHMktH?=
 =?utf-8?B?VFZONHJaa1VrVUFqTFBLOEJvK2xxSWxkS1pwUlVaMXltZU1aczZQeHhmUEhF?=
 =?utf-8?B?YVdVckVmZnUvQWljTTVjMi9pTnBYM0dQVENwUVA0UVI2ZnZmVS9mRUhwYWVW?=
 =?utf-8?B?Wlc0Rk9BTUhnZmRIMWt6VjROUHV3YzhuenNTZGdnMkdZUm1iRlFIeitaME93?=
 =?utf-8?B?bVNVMVVRSUl0SWlENDJqa3htZ0E3NWpPbkFNMkFnS09ZWUVmajZ6RHFpeklY?=
 =?utf-8?B?Z2NWR2t5Znk2NVRVdzBNRGtrNDhvL1FzMEtIaUx2VDc2M2Yyd0JkU202NGpX?=
 =?utf-8?B?RHV3cFBhaWNmV3puYVhmTlQzcjM2dzNNbU5DdjlrOUl0N1c0MTBaemcwOUs3?=
 =?utf-8?B?elVyMUw1U0pFUXVOcDZGUzFMRFZlclRTam1JTXlsUmVWbGMwT2VwUjcvRVhk?=
 =?utf-8?B?L3kvYWJ5cTVFeFpQbXJyWjgxdUljUTlMUDVuNjVTQ0JrS05temxraGpKeTgy?=
 =?utf-8?B?cmNYTjl4eXJiR0ovZndnQlFIa2l0VkZQcU9zbVMwbG5wUFZ1eW9aRGEzbFoz?=
 =?utf-8?B?Ly90MHZjOTBqK0VQdWF5S1h6VVdHTnUyOGs1a21sN2c5cGRydGMvSTgvMFNm?=
 =?utf-8?B?SGJyQnNYb1RCTHQyS1BCRlEwbmlnQXNFU2VxOENtdndxWEQwZzdVcnhtSWM3?=
 =?utf-8?B?UEJaZ3Y3dHBFVm1NNHpDdVgxRzZtT2pVeFQyTVg2U0pDYVVadk5Obm5pK2FI?=
 =?utf-8?B?V01TMEd4VmF4WGUwZ0laUTI1ZnZ2WDcvYk40ZmZJUWlGajBBWTIyeG8wQWlJ?=
 =?utf-8?B?cjRqYmprWmtQNHg3dThia1FNQzh2eWxDaUo5Y0NUd21BWmtpbGlvKzdCMnFP?=
 =?utf-8?B?SWRPNkhqWUVyK0JqS2IxZWQ4NkxNOHB6MDVMVUN5eFJpTjZ0ZkMwUllTMk5r?=
 =?utf-8?B?OC9xWVR6UTRHdW9oZ2JBR0xySk0wZktFN0VhZ0wzSWd1MXl4Qjl3ck1lclNx?=
 =?utf-8?B?ejBDNzJ4L05QTk9SN2kyazNjT3l3SFZWSnFXL1dTWHpZalVJcXN4V1RpczBG?=
 =?utf-8?B?ckZCYlNTOE92b2tGNkFhcmNwV3NadDFndElqVnRQKzNXK3VTZGVPek95blIy?=
 =?utf-8?B?dVlzRjVrVnVKQU1IUkxudkdIdCsrZ2t2Z2RhUFVOZE45Q1AxUzRQb0pOYXRC?=
 =?utf-8?Q?Op7VxzqUWrV05xNlSnukHUIiD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22df32a3-496b-4f4c-cc05-08dd60438d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 02:22:20.0768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0cL5Y9xoktrlo/wEdVBpGJEP79S/vXZvLEwbvKR7Uj+XN6eEeSn3JikB4Ok1jhwglckILlL5xSNk6ozaNJgZRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAzLCAyMDI1IDk6NTIgQU0NCj4gVG86
IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz47IERhdmlkIFRob21wc29u
DQo+IDxkYXZ0aG9tcHNvbkBudmlkaWEuY29tPg0KPiBDYzogU2hyYXZhbiBSYW1hbmkgPHNyYW1h
bmlAbWVsbGFub3guY29tPjsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxrbWwNCj4gPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbYnVnIHJlcG9ydF0g
RURBQywgbWVsbGFub3g6IEFkZCBFQ0Mgc3VwcG9ydCBmb3IgQmx1ZUZpZWxkIEREUjQNCj4gDQo+
IE9uIFRodSwgT2N0IDI0LCAyMDI0IGF0IDExOjIwOjQ1QU0gKzAzMDAsIERhbiBDYXJwZW50ZXIg
d3JvdGU6DQo+ID4gSGVsbG8gU2hyYXZhbiBLdW1hciBSYW1hbmksDQo+ID4NCj4gPiBDb21taXQg
ODI0MTNlNTYyZWE2ICgiRURBQywgbWVsbGFub3g6IEFkZCBFQ0Mgc3VwcG9ydCBmb3IgQmx1ZUZp
ZWxkDQo+ID4gRERSNCIpIGZyb20gSnVuIDI1LCAyMDE5IChsaW51eC1uZXh0KSwgbGVhZHMgdG8g
dGhlIGZvbGxvd2luZyBTbWF0Y2gNCj4gPiBzdGF0aWMgY2hlY2tlciB3YXJuaW5nOg0KPiA+DQo+
ID4gZHJpdmVycy9lZGFjL2JsdWVmaWVsZF9lZGFjLmM6MjA1IGJsdWVmaWVsZF9nYXRoZXJfcmVw
b3J0X2VjYygpIGVycm9yOg0KPiB1bmluaXRpYWxpemVkIHN5bWJvbCAnZHJhbV9zeW5kcm9tJy4N
Cj4gPiBkcml2ZXJzL2VkYWMvYmx1ZWZpZWxkX2VkYWMuYzoyMTkgYmx1ZWZpZWxkX2dhdGhlcl9y
ZXBvcnRfZWNjKCkgZXJyb3I6DQo+IHVuaW5pdGlhbGl6ZWQgc3ltYm9sICdkcmFtX2FkZGl0aW9u
YWxfaW5mbycuDQo+ID4gZHJpdmVycy9lZGFjL2JsdWVmaWVsZF9lZGFjLmM6MjMxIGJsdWVmaWVs
ZF9nYXRoZXJfcmVwb3J0X2VjYygpIGVycm9yOg0KPiB1bmluaXRpYWxpemVkIHN5bWJvbCAnZWRl
YTAnLg0KPiA+IGRyaXZlcnMvZWRhYy9ibHVlZmllbGRfZWRhYy5jOjIzMSBibHVlZmllbGRfZ2F0
aGVyX3JlcG9ydF9lY2MoKSBlcnJvcjoNCj4gdW5pbml0aWFsaXplZCBzeW1ib2wgJ2VkZWExJy4N
Cj4gPiBkcml2ZXJzL2VkYWMvYmx1ZWZpZWxkX2VkYWMuYzoyNTYgYmx1ZWZpZWxkX2VkYWNfY2hl
Y2soKSBlcnJvcjogdW5pbml0aWFsaXplZA0KPiBzeW1ib2wgJ2VjY19jb3VudCcuDQo+ID4NCj4g
PiBkcml2ZXJzL2VkYWMvYmx1ZWZpZWxkX2VkYWMuYw0KPiA+ICAgICAxNzMgc3RhdGljIHZvaWQg
Ymx1ZWZpZWxkX2dhdGhlcl9yZXBvcnRfZWNjKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwNCj4g
PiAgICAgMTc0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZXJy
b3JfY250LA0KPiA+ICAgICAxNzUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGludCBpc19zaW5nbGVfZWNjKQ0KPiA+ICAgICAxNzYgew0KPiA+ICAgICAxNzcgICAgICAg
ICBzdHJ1Y3QgYmx1ZWZpZWxkX2VkYWNfcHJpdiAqcHJpdiA9IG1jaS0+cHZ0X2luZm87DQo+ID4g
ICAgIDE3OCAgICAgICAgIHUzMiBkcmFtX2FkZGl0aW9uYWxfaW5mbywgZXJyX3ByYW5rLCBlZGVh
MCwgZWRlYTE7DQo+ID4gICAgIDE3OSAgICAgICAgIHUzMiBlY2NfbGF0Y2hfc2VsZWN0LCBkcmFt
X3N5bmRyb20sIHNlcnIsIGRlcnIsIHN5bmRyb207DQo+ID4gICAgIDE4MCAgICAgICAgIGVudW0g
aHdfZXZlbnRfbWNfZXJyX3R5cGUgZWNjX3R5cGU7DQo+ID4gICAgIDE4MSAgICAgICAgIHU2NCBl
Y2NfZGltbV9hZGRyOw0KPiA+ICAgICAxODIgICAgICAgICBpbnQgZWNjX2RpbW0sIGVycjsNCj4g
PiAgICAgMTgzDQo+ID4gICAgIDE4NCAgICAgICAgIGVjY190eXBlID0gaXNfc2luZ2xlX2VjYyA/
IEhXX0VWRU5UX0VSUl9DT1JSRUNURUQgOg0KPiA+ICAgICAxODUgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBIV19FVkVOVF9FUlJfVU5DT1JSRUNURUQ7DQo+ID4gICAgIDE4Ng0K
PiA+ICAgICAxODcgICAgICAgICAvKg0KPiA+ICAgICAxODggICAgICAgICAgKiBUZWxsIHRoZSBF
eHRlcm5hbCBNZW1vcnkgSW50ZXJmYWNlIHRvIHBvcHVsYXRlIHRoZSByZWxldmFudA0KPiA+ICAg
ICAxODkgICAgICAgICAgKiByZWdpc3RlcnMgd2l0aCBpbmZvcm1hdGlvbiBhYm91dCB0aGUgbGFz
dCBFQ0MgZXJyb3Igb2NjdXJyZW5jZS4NCj4gPiAgICAgMTkwICAgICAgICAgICovDQo+ID4gICAg
IDE5MSAgICAgICAgIGVjY19sYXRjaF9zZWxlY3QgPSBNTFhCRl9FQ0NfTEFUQ0hfU0VMX19TVEFS
VDsNCj4gPiAgICAgMTkyICAgICAgICAgZXJyID0gYmx1ZWZpZWxkX2VkYWNfd3JpdGVsKHByaXYs
IE1MWEJGX0VDQ19MQVRDSF9TRUwsDQo+IGVjY19sYXRjaF9zZWxlY3QpOw0KPiA+ICAgICAxOTMg
ICAgICAgICBpZiAoZXJyKQ0KPiA+ICAgICAxOTQgICAgICAgICAgICAgICAgIGRldl9lcnIocHJp
di0+ZGV2LCAiRUNDIGxhdGNoIHNlbGVjdCB3cml0ZSBmYWlsZWQuXG4iKTsNCj4gPiAgICAgMTk1
DQo+ID4gICAgIDE5NiAgICAgICAgIC8qDQo+ID4gICAgIDE5NyAgICAgICAgICAqIFZlcmlmeSB0
aGF0IHRoZSBFQ0MgcmVwb3J0ZWQgaW5mbyBpbiB0aGUgcmVnaXN0ZXJzIGlzIG9mIHRoZQ0KPiA+
ICAgICAxOTggICAgICAgICAgKiBzYW1lIHR5cGUgYXMgdGhlIG9uZSBhc2tlZCB0byByZXBvcnQu
IElmIG5vdCwganVzdCByZXBvcnQgdGhlDQo+ID4gICAgIDE5OSAgICAgICAgICAqIGVycm9yIHdp
dGhvdXQgdGhlIGRldGFpbGVkIGluZm9ybWF0aW9uLg0KPiA+ICAgICAyMDAgICAgICAgICAgKi8N
Cj4gPiAgICAgMjAxICAgICAgICAgZXJyID0gYmx1ZWZpZWxkX2VkYWNfcmVhZGwocHJpdiwgTUxY
QkZfU1lORFJPTSwNCj4gJmRyYW1fc3luZHJvbSk7DQo+ID4gICAgIDIwMiAgICAgICAgIGlmIChl
cnIpDQo+ID4gICAgIDIwMyAgICAgICAgICAgICAgICAgZGV2X2Vycihwcml2LT5kZXYsICJEUkFN
IHN5bmRyb20gcmVhZCBmYWlsZWQuXG4iKTsNCj4gPg0KPiA+IElmIGJsdWVmaWVsZF9lZGFjX3Jl
YWRsKCkgZmFpbHMgdGhlbiBkcmFtX3N5bmRyb20gaXMgdW5pbml0aWFsaXplZC4NCj4gPg0KPiA+
ICAgICAyMDQNCj4gPiAtLT4gMjA1ICAgICAgICAgc2VyciA9IEZJRUxEX0dFVChNTFhCRl9TWU5E
Uk9NX19TRVJSLCBkcmFtX3N5bmRyb20pOw0KPiA+ICAgICAyMDYgICAgICAgICBkZXJyID0gRklF
TERfR0VUKE1MWEJGX1NZTkRST01fX0RFUlIsIGRyYW1fc3luZHJvbSk7DQo+ID4gICAgIDIwNyAg
ICAgICAgIHN5bmRyb20gPSBGSUVMRF9HRVQoTUxYQkZfU1lORFJPTV9fU1lOLCBkcmFtX3N5bmRy
b20pOw0KPiA+DQo+IA0KPiBUaGlzIGxvb2tzIGZvcmdvdHRlbi4NCj4gDQo+IEknbSB0aGlua2lu
ZyBvZjoNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGlu
ZGV4IDhlMDczNmRjMmVlMC4uMDYxMTQ5YWRlOGMwIDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVS
Uw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtODIyMiw4ICs4MjIyLDcgQEAgRjoNCj4gCURv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9lZGFjL2FzcGVlZC1zZHJhbS1lZGFjLnR4
dA0KPiAgRjoJZHJpdmVycy9lZGFjL2FzcGVlZF9lZGFjLmMNCj4gDQo+ICBFREFDLUJMVUVGSUVM
RA0KPiAtTToJU2hyYXZhbiBLdW1hciBSYW1hbmkgPHNocmF2YW5rckBudmlkaWEuY29tPg0KPiAt
UzoJU3VwcG9ydGVkDQo+ICtTOglPcnBoYW4NCj4gIEY6CWRyaXZlcnMvZWRhYy9ibHVlZmllbGRf
ZWRhYy5jDQo+IA0KPiAgRURBQy1DQUxYRURBDQo+IA0KPiBidXQgbGVtbWUgQ2MgcGVvcGxlIHdo
byBoYXZlIHRvdWNoZWQgdGhpcyByZWNlbnRseSBmaXJzdC4NCj4gDQo+IFRoeC4NCj4gDQo+IC0t
DQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jpcy4NCj4gDQo+IGh0dHBzOi8vcGVvcGxlLmtl
cm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQoNClNocmF2YW4gYW5kIEkgd2ls
bCBpbnZlc3RpZ2F0ZSBzb2x2aW5nIHRoaXMgJ3NtYXRjaCcgd2FybmluZy4NCg0KSSBzZXR1cCBh
IHJlY2VudCBsaW51eC1uZXh0IHJlcG8sIGluc3RhbGxlZCB0aGUgc3BhcnNlIHBhY2thZ2UsIGFu
ZCBkb3dubG9hZGVkICsgYnVpbHQgdGhlIHNtYXRjaCB0b29sLiAgDQpJIGV4ZWN1dGUgdGhlIGZv
bGxvd2luZyBjb21tYW5kIHRvIHJ1biAnc21hdGNoJyBvdmVyIHRoZSBlbnRpcmUgbGludXgga2Vy
bmVsLCBpbmNsdWRpbmcgYmx1ZWZpZWxkX2VkYWMuYzoNCiAgICQgbWFrZSBDSEVDSz0iL3BhdGgv
dG8vc21hdGNoIC1wPWtlcm5lbCAtLWZpbGUtb3V0cHV0IiBDPTEgLWo2NA0KDQpJIGRvbid0IHNl
ZSBhbnkgd2FybmluZ3MgcmVsYXRlZCB0byB0aGUgYmx1ZWZpZWxkX2VkYWMuYyBtb2R1bGUuIFRo
YXQgaXMsIHRoZSBnZW5lcmF0ZWQgZmlsZSANCiJkcml2ZXJzL2VkYWMvYmx1ZWZpZWxkX2VkYWMu
Yy5zbWF0Y2giIGhhcyBzaXplIDAsIGFuZCB0aHVzIG5vIGNvbnRlbnQuDQoNCldoYXQgaXMgdGhl
IHJlY29tbWVuZGVkIGNvbW1hbmQgbGluZSBvcHRpb25zIHRvIHBhc3MgdG8gTGludXgga2VybmVs
IGJ1aWxkPw0KSXMgdGhlcmUgc29tZXRoaW5nIEkgYW0gbWlzc2luZyBoZXJlPw0KDQotIERhdmUg
DQo=

