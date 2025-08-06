Return-Path: <linux-edac+bounces-4531-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635EBB1CE5A
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 23:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D145724571
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 21:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCB2221299;
	Wed,  6 Aug 2025 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F2xT3y3X"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCEE1B78F3;
	Wed,  6 Aug 2025 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515443; cv=fail; b=AlbsTArMUe4R/e1ffOUUya/li07Qx48T+mmtdJEQIQXxOeQiB1m3y2T1F7zkXAtgureexrd+epHIn8q7CErb7BJHO544hgMD01wW6TzqkxdlG5X4xA9T0zq8UeoalZBUNptuTti3sHzbgSOgxZQdQzeyRA13kyoFijqz4Doi7vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515443; c=relaxed/simple;
	bh=iwWu4CnZvFTroG2ngk4HnDtXOz9duR0TUqw40fJozlg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UF+CcqBNjHNBxRTewZIGKU0cHmGGlZ0nOWCQCy/V9F+kx7u2PK8hDSqT0ROltbYICKRCt4fuIAbhsx2psQuNTNzGLkN4DPt8suAxez3qhHJ+EVQlbrpw982JXS328bSQ6VVjUsoM/ZtzvKBCSwpTWB6bvTOQmE/GUBaffkhRI2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F2xT3y3X; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0gFHmGVyRs956xFBlJUZqLcxZTAP9auKcnmZX70QKOL/buwjv0e5/HVRHZPW1NwTvaI1hYiCRq7q72KPnt4h9R/kMtFZbGHVZPDXqncAE3MmzPkIMLJ8qKyOzILF9l05PJ5fFon7MoUIeitvrBE/UdUEGtVn4KvGrMfje12DKtuNl4u5OT6mncFjGPw0T1ZAodoZhrThyGzivEupaUesqFHvDLu0Dt6Y5RsFcNHOdwzLkp6DcRKRKw3SVNeUiwPKRbAmQ35CKCA7aQhmMcelFYn5JkQBGQzGy65rfupgZO8jZuHlNl3OnANZCpdAJmLDA/vHnF1TBEIwp968DgWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoFzVvuGMdamx1DyIbbNimOI9576ulEQVB/WS3r6yqU=;
 b=b8YXnpMf5Mjl1Qd6pkEJs+Q9K8og/RCM/HaQy40JEpx+09J1mPW9hdVNrTxlXrFQS+ujz6zPG2uKcJlf8801oSzHmF0nPyvoIes9d4N8PkVypHNj9NPMFZ7YVuhbnjS7jjHlhh62Uae58VQj+V0IZO7kjlMO/g+D1AEh/naRoI4U0iNxNKouLUqgLU5mXPQ1EyT7WTTBTWsC7Z1jltlznDc9A4E12pFBMee36FeBx4oqyTywc+h5WO7J3zbgkuoRsBgNSQin8r6tInNOoBGbdBfoM6eesbO24+ZMVMmZWOIrF6B66lJWJCIL/kzEwCmGoPY/xIE+vJR766Uz4biZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoFzVvuGMdamx1DyIbbNimOI9576ulEQVB/WS3r6yqU=;
 b=F2xT3y3Xou4KcQcO7gH/+BMFk1jM8qr9t0kb3k5WNgudpMW1izAfc7o36hbPaHiia4qGM511ZBXkldKnQMbPU1jirrcv/ULB5ErOMkHdwHOliYetbn0HWYw4LZcCsUtr4sDt6GsIVagwwYU9iIVxUY9oaoXZZKRP+/tq9se2Fy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Wed, 6 Aug
 2025 21:23:58 +0000
Received: from BL1PR12MB5378.namprd12.prod.outlook.com
 ([fe80::9cf4:a6ba:b42f:d135]) by BL1PR12MB5378.namprd12.prod.outlook.com
 ([fe80::9cf4:a6ba:b42f:d135%5]) with mapi id 15.20.8989.015; Wed, 6 Aug 2025
 21:23:57 +0000
Message-ID: <b8275fc1-d99c-4e9e-9326-d0e2373ef279@amd.com>
Date: Wed, 6 Aug 2025 16:23:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mce: Add support for PHYSADDRV and
 PHYSADDRVALIDSUPPORTED bits
To: Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org, bp@alien8.de,
 tony.luck@intel.com, linux-kernel@vger.kernel.org
References: <20250729204801.1044100-1-avadhut.naik@amd.com>
 <20250806125220.GA628281@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250806125220.GA628281@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::23) To BL1PR12MB5378.namprd12.prod.outlook.com
 (2603:10b6:208:31d::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5378:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5465b4-34c7-4807-0876-08ddd52f8de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NCtJSk5nN2ErRk5mMWdhTXdONXpwKys5c3ZxTzlJWTdoOWlpVVl0cUVuQVV2?=
 =?utf-8?B?V3RkeU5Db3F5WHZEcStta1VMWWVNSHk2UGNXUU00Z3lCOFZUbEZQeUg2L20v?=
 =?utf-8?B?ZHNjNDNMUHFFbDFlOUY0SjB0UmpHSFNaSnVPQ24vZTdGNm5haDJkUnZxRmZL?=
 =?utf-8?B?VThPZENPUVFnSnpoNmEwOGFCTEN4VzgvTm04WkR2VHFwYkUvQnEzTGVUV3Ri?=
 =?utf-8?B?OHBsQ3d1cVNnOWV6RCs1aWpPazJ2Z1FCR3Z6SjFtWjlMMXcwYVVnb0ZmYm1N?=
 =?utf-8?B?c1VaUTdZbGtVSWNxd0t3akFKZ21GU0FxWnBGWmdkRVZVT0lERVZUaDJTNWVj?=
 =?utf-8?B?VlBPSkFzeFBqQ3RjeVZEZ1YxL1dWQ2hmMXpDYjdSNE5xeGhzb2ZqQmVJL3J1?=
 =?utf-8?B?MUFzeVNFdGZIWVIrT1FaeENDUHQ2TkMybG5WOWluQkYyaklSUFp0cXd5RzlK?=
 =?utf-8?B?S1d6NkVNVEI4cy9HM3ZSUnBoZEFLVWRGNWxwampWUEo5YUJ3ZzhwTnZRbUls?=
 =?utf-8?B?QlR4TnozYlEwQkdyU3pzYkhNUmgvRDRERFhkbXI3dlZVOUhGMGZ1MHdweGhu?=
 =?utf-8?B?T2lXWTlSSEJ1Q09BY3IxUFVoTnhKb0grblJrV2xPVzlBUUZOakdlVlg1NU1y?=
 =?utf-8?B?WDZmMmFHTWVtb3hYb1lhU0VYcVdFSE1DcTEzYkhWM2dScjl1blh5ZVFZYXhk?=
 =?utf-8?B?RXRrM0dpZHdiNHFWclU2Q3pPSXNnR0FjTWpDbkNSOEVuQldRWSthd3h6cEpF?=
 =?utf-8?B?R0hnZmhTV2REOHQyekovcEd0bDR4bGpPZWVPZXd6VHc1eDVDUVJ4eEdhdkxs?=
 =?utf-8?B?R1dHRldPaUdrU3ZrOXNwbzduZVNvS2o2RE42Ty9KQWw3akU4OU5KZi9qMkds?=
 =?utf-8?B?OVBSU1JYampwYzE2eU9DUHRLOGgwRkhTNjJuWDVjQUJ2ejZseFhtWStacitn?=
 =?utf-8?B?MDAzczB1UnYzV1lNYmFiaFArMWN1YzM5TFQxSE8ySVVvcFJkYzJXaTI1TUsv?=
 =?utf-8?B?ZVlRYmhyYVhCVVU2MnpYZXQ1ZTFRcVRjdDdwQUk4U0swckhtRUtFTXRWZUp1?=
 =?utf-8?B?RDBqWHJpbGF4L25ET2lHS0UrSGt6NnhXRnpyYzhhSGh6djdRVi9aS3l4YUxz?=
 =?utf-8?B?YThLUm43R05LaFkwS0hRbDNVRXpsd25rdTB0dlc0SWxXdmVWZkUwejdNaDM5?=
 =?utf-8?B?U2dKdFBDWENaTjlud2JkY1p5bkJUOEZNNDBCajM1N0dRU253RjFxWGYrRnV4?=
 =?utf-8?B?SW52anltbmh0U21uL2p2U3hjdmdtOW5majNYbm1mRWVwWFF6WXhsMmE3LzQ2?=
 =?utf-8?B?c25QS1JNd28yMnhEd3ZmNEF3ZkdIRERxdUZYU3Nsbi9YQXpicmpjUGVvbzVl?=
 =?utf-8?B?SlMyR0cyclpkZVpxdDN2WCtJOWdwMzBzaC84TVdYa2FHVWNpQkIzbm85YjFy?=
 =?utf-8?B?QlZzRGdxcmdyUTBkd29TS0dYcnp1RkFPSVZtVG9YSTM3RTk2c3ltZUwyd1Rj?=
 =?utf-8?B?NWJBbFdValNWN2FoaUplalFZTUZ4bGdEbE56Nk1oTHFxSXUrM0FndnQ3bU02?=
 =?utf-8?B?dllOQW8rL2VXdFJneUNCWjZObDlpRFgvVVFualhkcUxzM3k3eVpqOXptYjUv?=
 =?utf-8?B?em9UVkRSQktYZXNjOWcwekZ0MitHTmhNVE9LSEdHaUlJbzlyV2E1MUltSmt6?=
 =?utf-8?B?b3V0SjZKM29YNXlRVHV5L3VzTWNQd09YQ0VITEtVMW04ZVh4MmYvMTFoNklv?=
 =?utf-8?B?cW9IOWJTcUd4VjFmcFpIU1p2c2VxZ1hrRytxdXdtM256eGRqTFhZUTN2OEpl?=
 =?utf-8?B?SWlaYkdDMDMvcDNMSUM5YVFFRU9KemIzYlQrVjJxSDZkb0RUMys0bXVNT2da?=
 =?utf-8?B?RnRiRTFOMnYwZkgzM1hJSlhXY2dLMzc1TFVJZlBweklOVm4rUnF3TUJ1V3Jl?=
 =?utf-8?Q?gSj/+5eNSno=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5378.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHBwa3NCY3dGS2lZRXdBeC9IRFcyVE1yeTlBY0lJOWxodjlQZW9RaUF6OXdB?=
 =?utf-8?B?ZW9PcElqU3VRK1ZHMnNXNkFrTWtTdDFPMmlkeGQvZWkzVnNlR1gyWTlUWWhF?=
 =?utf-8?B?R3NEWDBZOTZjbWRCdnZDRTJBZy9TOEkvWGQ5Qlg1aTZGOE80SDJVbmJvZzVT?=
 =?utf-8?B?OTlIR0NIYkFtK1Rya0JacjRGeXNJWnpmanM4MzhrdS92K0NvMmUxOU9rZHlr?=
 =?utf-8?B?M3ZycVJrdlo5N0VtL1I3bDFxWmxkUGdmcWg5QndNZ04vQWZhenZiQ3ZqOVZ2?=
 =?utf-8?B?TnpwKzZHRGxGRWlCUkk2aHVZSXBXUkZRd0lTRENhYndhWWhUT1RVR3NYUnNh?=
 =?utf-8?B?dzVWMjhDSWtjaVdHU3pQL2hRV3BlWlVJYmdDcCt2YUh4NkJZWklJeFhydlE4?=
 =?utf-8?B?M3BtV2w0cklMZDVxeGl3Skt2eUhjY0gzUUVNVUxpNHRSTDhjZXBxamsxRVNO?=
 =?utf-8?B?OXVsNThkK25Ca3VnczhuQnVjQzByOHpWTExHSlVBTjUwSHRWOGoxOEFLVTZS?=
 =?utf-8?B?ZktIQ3J2dEpxM0kyTjFxcThQS1RoYS9JTktabVJHMXQ4OUlSY2VIRExPL21a?=
 =?utf-8?B?RFJUYjRDN1NUcUQrSW5Ea1dEbkxVcHlteDRCajF5eXM3dmRNZ2Q5K3JsVnpm?=
 =?utf-8?B?aDJJYnNwcXBqN09kZzl1bmdsZllSVG9RdEJkWGl6ZHB1WHRaTEFQY0lla05x?=
 =?utf-8?B?VDVKYUt3ajJCL25abytiMVE1YTBsWmJ2WG5oaUdacGFaQ0x5RjVmSjRmaHdB?=
 =?utf-8?B?OWFSZ1N4a25uY2x2NHMvcytjQnFZMHhlRVUvWFg5RUpONEdIK0grSzUrWm01?=
 =?utf-8?B?YkorSXNzV2N1eEJlVVRyNjhBSDRRb1pKK2hyVVJ0RmRoUWNTalJveUJ2Z1F0?=
 =?utf-8?B?d2x4Y09NUXd0U0l0ZDVjVDcyWXdUZ1BlcmorbFJ4S091dTBSR0IyY2Q4VGg0?=
 =?utf-8?B?ZzROK014eFA3SHduWVU0WEcveXJFL3RoODFUV2MwUG9lRUdwRFZSRDFjQlh0?=
 =?utf-8?B?NmlPVEkxV1YzUXpXam53ZUxscmFDM2lOZHUzbE9PYlpUQjFSSG5ndjV1aXo4?=
 =?utf-8?B?amdMZlJzcXZIWTRqc3dnUmtMbWNYcTE0d04waTNrV3NlZDA2cWNZYW5ZMHd1?=
 =?utf-8?B?MnVBTnlUZ0s0dStXbmxVT3JGelhLRjAwMXNTcHhaUEVDbTM2d2I2eXlJNUpu?=
 =?utf-8?B?ZkRJdDJ0VHd3V1lETWVPNHRUajNTeEtmY3ppQm5EU1ZkOHcyd3RLTzgxZ2NK?=
 =?utf-8?B?Q3lYV05PNENnUE11WjFaZnF3cjQ0d1o2UHd4ZDg3U3c2V2NBb3F2c1gwZFN6?=
 =?utf-8?B?dFdHQ244L054TmU4dHN5K3V1UWRqSkxMMFkxamxhdlZPbnpXazlkdUpQQ01Y?=
 =?utf-8?B?UzRFYWFZWWYzODR3Tm1tanVOemR2SzRXYXpCSHRRSllQS2ZpRVorSWZ0NFRO?=
 =?utf-8?B?azdCZW9oZnc1UXo0VHJrNUxZaDFENXU0VWV1NDdPdThqSTlhcmFzZ1BwOXNv?=
 =?utf-8?B?RjZRK01rVFJHTXIwMldmTXZJYTVmd0pxYVlDZmZNNzJLanFPWjFxS01sMmsy?=
 =?utf-8?B?WEZBTUxzMUJ1TFI1Z1o1bHpTWTBPUjMrTG0wNnZ5NG5LODdudFpXRm5FMk5j?=
 =?utf-8?B?YitjWXYrdTIyN05yTkw2dEJXR0JIUmp4TmhhaXVjdjZySlJhRnkvSWF0RzFj?=
 =?utf-8?B?cC9hQ0FRMFZRR1VvaE95dm93dUc0Tm0vWVJ6SUxPbGlWKzRveFJIeG9ia1J5?=
 =?utf-8?B?UVpTZ2ZvZ3ZCNXhOSi9PZDBHR0lFN0twU2Y1SGN4aGhrSW15QzB4RTVMeDlx?=
 =?utf-8?B?bGRKaWRjS2lNb2RMUnBpMHRUcmFnaHdBZ21Sd1k5Mzk5cXJZNkIrRHVhYTE3?=
 =?utf-8?B?ZmRuS1lzd3hZTlN2OFNMREpwdzZzWk5sNU5xQlpTWWp1ZlpLMU10Q2dxaEtG?=
 =?utf-8?B?bEVaUkUrUGYzVnYxOFBkT2lqdmxDUG1qUTRyWE45b2V6T3QyZktRY1FlRSsy?=
 =?utf-8?B?OUlueW5PSzM1a1ZkOUlqS2RWNTlkQXJGS2p4eWVVNHEybjdHU2hHNHhQOVNJ?=
 =?utf-8?B?Ui8yUjNXNU0ydTNLalRldGlWM3BvYWo3VEFHaHZiTi9NYVNsMkR4WWFKUDJR?=
 =?utf-8?Q?JG620Y7v9Ex9oytgfY8znLIsq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5465b4-34c7-4807-0876-08ddd52f8de8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5378.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:23:57.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Bm6IC7EzxNVGS3P9T4RXbRNYkb9r91j1fPdIblTaBnUYPSiDSI26Ktjhi+yOmumqLPajnxNVccOps4HbBxCEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349

Hi,

On 8/6/2025 07:52, Yazen Ghannam wrote:
> On Tue, Jul 29, 2025 at 08:46:57PM +0000, Avadhut Naik wrote:
>> Starting with Zen6, AMD's Scalable MCA systems will incorporate two new
>> bits in MCA_STATUS and MCA_CONFIG MSRs. These bits will indicate if a
>> valid System Physical Address (SPA) is present in MCA_ADDR.
>>
>> PhysAddrValidSupported bit (MCA_CONFIG[11]) serves as the architectural
>> indicator and states if PhysAddrV bit (MCA_STATUS[54]) is Reserved or
>> if it indicates validity of SPA in MCA_ADDR.
>>
>> PhysAddrV bit (MCA_STATUS[54]) advertises if MCA_ADDR contains valid
>> SPA or if it is implementation specific.
> 
> The commit message is missing an imperative statement. You can describe
> how and why these bits are helpful.
> 
> For example: "Use and prefer MCA_STATUS[PhysAddrV] when checking for a
> usable address." or something like this.
> 
Will add it.

>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>>  arch/x86/include/asm/mce.h    |  2 ++
>>  arch/x86/kernel/cpu/mce/amd.c | 16 +++++++++++++---
>>  2 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
>> index 6c77c03139f7..387cf250525f 100644
>> --- a/arch/x86/include/asm/mce.h
>> +++ b/arch/x86/include/asm/mce.h
>> @@ -48,6 +48,7 @@
>>  
>>  /* AMD-specific bits */
>>  #define MCI_STATUS_TCC		BIT_ULL(55)  /* Task context corrupt */
>> +#define MCI_STATUS_PADDRVAL	BIT_ULL(54)  /* Valid System Physical Address */
>>  #define MCI_STATUS_SYNDV	BIT_ULL(53)  /* synd reg. valid */
>>  #define MCI_STATUS_DEFERRED	BIT_ULL(44)  /* uncorrected error, deferred exception */
>>  #define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
>> @@ -62,6 +63,7 @@
>>   */
>>  #define MCI_CONFIG_MCAX		0x1
>>  #define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
>> +#define MCI_CONFIG_PAVALID	BIT_ULL(11)
>>  #define MCI_IPID_MCATYPE	0xFFFF0000
>>  #define MCI_IPID_HWID		0xFFF
>>  
>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>> index 5c4eb28c3ac9..6ac222aec28d 100644
>> --- a/arch/x86/kernel/cpu/mce/amd.c
>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>> @@ -748,9 +748,9 @@ bool amd_mce_is_memory_error(struct mce *m)
>>  }
>>  
>>  /*
>> - * AMD systems do not have an explicit indicator that the value in MCA_ADDR is
>> - * a system physical address. Therefore, individual cases need to be detected.
>> - * Future cases and checks will be added as needed.
>> + * Some AMD systems have an explicit indicator that the value in MCA_ADDR is a
>> + * system physical address. Individual cases though, need to be detected for
>> + * other systems. Future cases will be added as needed.
>>   *
>>   * 1) General case
>>   *	a) Assume address is not usable.
>> @@ -764,11 +764,21 @@ bool amd_mce_is_memory_error(struct mce *m)
>>   *	a) Reported in legacy bank 4 with extended error code (XEC) 8.
>>   *	b) MCA_STATUS[43] is *not* defined as poison in legacy bank 4. Therefore,
>>   *	   this bit should not be checked.
>> + * 4) MCI_STATUS_PADDRVAL is set
>> + *	a)Will provide a valid system physical address.
> 
> Space after "a)".
>
Noted.
 
>>   *
>>   * NOTE: SMCA UMC memory errors fall into case #1.
>>   */
>>  bool amd_mce_usable_address(struct mce *m)
>>  {
>> +	u64 smca_config;
>> +
>> +	rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(m->bank), smca_config);
> 
> Newline here.
> 
Noted.

>> +	if (smca_config & MCI_CONFIG_PAVALID) {
>> +		if(m->status & MCI_STATUS_PADDRVAL)
>> +			return true;
>> +		return false;
>> +	}
> 
> Newline here.
>
Noted.
 
> Also, the entire hunk above should go after the !SMCA case below and
> before the other SMCA cases.
> 
> Furthermore, the hunk can be simplified to this:
> 
> 	if (smca_config & MCI_CONFIG_PAVALID)
> 		return m->status & MCI_STATUS_PADDRVAL;
> 
Ack for both.

> Also also, the bit names are uncannily similar. I think they should be
> the same (except for the prefix) or clearly different.
> 
> MCI_CONFIG_PADDRV/MCI_STATUS_PADDRV
> 
> MCI_CONFIG_PHYS_ADDRV_SUPP/MCI_STATUS_PADDRVAL
> 

Will change the name per your suggestions.

>>  	/* Check special northbridge case 3) first. */
>>  	if (!mce_flags.smca) {
>>  		if (legacy_mce_is_memory_error(m))
>>
>> base-commit: d69139008b6dcd9c18483e956f61d187b0c214a2
>> -- 
> 
> We should revisit saving MCA_CONFIG during logging. We end up reading it
> multiple times during error processing.
> 
> I realize this came up before in a previous patch set. IIRC, the point
> of contention was exposing MCA_CONFIG to userspace. We don't necessarily
> have to do that. We can just use it in the kernel data structures.
> 
I agree. If there is consensus, I can work on getting a patch out.
Maybe make this a set with the first patch caching MCA_CONFIG and
this being the second patch.

> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik


