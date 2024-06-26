Return-Path: <linux-edac+bounces-1386-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E3B918DB6
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 20:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F34EB24B6D
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 18:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2707F190073;
	Wed, 26 Jun 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EpHQUSCn"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C115B55D;
	Wed, 26 Jun 2024 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424840; cv=fail; b=Kt4YNA9daEpITXxWFdgeiwZ006lqFv3gs4Fz15QvOyHFSSloLQA+XbNTscUw5DQflGsVWpd1dU8fxxEMcwT8sdWfPHQe1Co0147ckPCMuokeXrPH/iKq4RtpdswFUzfjlOgERcBIH0Nm5rWFlcox2OOTluuvriWSyeZ5NfiqUzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424840; c=relaxed/simple;
	bh=Riz4gyyU8+/1CwbrGqfyqIdVM1cehOlxukFvk0/bvg4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=COE2lug4S7ZTkjL1kIVl/9+5iZb37aAB6LxoGvpzoRQrMkK+Av2d6wAobKYIgHiT6eOvnRkk/N+LJYd1n/tVOKpdFKtWpbiGDyNoQ9sTyl0cgTu+lNT1CiYuMGJAbyitB9pYTBDtDU5d9wM6hpZHDOQghAlKHgJ8DAmKl7N0uh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EpHQUSCn; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goLwkkE8ZpGI8Tflpc+kafR0pJ7w+LhkNIoHiOqjUDcfeMK2SSd6Eo5bTarAojzPKt1WFQWhf3TEOvEuXYKEhIiv6dEiYkrG26y3XgrnZAP94bD/4YFJxZ8+P1dPQZrxHMxy6UKGSiQWd/Q/kCPw/TVD803BewAg9QWOPv/3WtZfXuDvWqrlBcblvyn6OdvL2VwDYE4b+OMRQ7Mbo2hul0Aq4LShTkOMFphOagAN56qQt2VwiCUTf9H+RPFlILlbhYJkwawHf0myuHtvqH/i3vrIyStnsCwGW/0N78TR7E0lQBTyMIYLVbNLvARrgjKqPBGkAlmRWyKtj1XJ9SG7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJXPPxqxyNiItkCfLsZLgy/AX8JM+hVN3NO23+G5XWE=;
 b=B5syZ9pFhJEp3YlYO8X98M5uTftNLjSYX/eSWCXUQsEOP+BQjoZptVyxd7VjwgRpaDt8Zp2Wl87tkw3GecCYHQw3OOIEMdmlPHk53VNV8QQ5KSvYQIFt+x16v8x4sTVBwc4kTEniVOC5+ZOUp7oq5nE04dYcHpPavsYB5QKekphB2+ZhafrC2F/PAFUJ0AJjh+qpf75fJ5a72N0kqw7B1NX2IHNmzNwwY0RH4r1emWYLx88//pkvk8uexMghQflNViGLx6/AM9bH+FAOSNwtpIDetn5x41N+enWr7D32Tx4UoZ6Id7uv7Iy+FiGe6x8BslV4frurIg5x+qxPaupiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJXPPxqxyNiItkCfLsZLgy/AX8JM+hVN3NO23+G5XWE=;
 b=EpHQUSCnGEIRTYaGSi+8+npERViG05VKudXeY8OcKVZiVM1ENOdAyjraErPvgf2gKMDYsdXw800kParto9hcIYP/ZCpnqKVEHKryGdHK/DDVnt1dhcweOhBrjODJ1WOQGEyvyD+Kix3HrAMfk5hfEIhUP6nVqdkEhOjdhIKz59A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Wed, 26 Jun
 2024 18:00:34 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 18:00:34 +0000
Message-ID: <ff9efb14-f3e5-4c4e-8285-7da853e6ffb7@amd.com>
Date: Wed, 26 Jun 2024 13:00:30 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/4] EDAC/mce_amd: Add support for FRU Text in MCA
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, rafael@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, rostedt@goodmis.org, lenb@kernel.org,
 mchehab@kernel.org, james.morse@arm.com, airlied@gmail.com,
 yazen.ghannam@amd.com, john.allen@amd.com
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-5-avadhut.naik@amd.com>
 <20240626120429.GQZnwDzQ47y1fOlFTp@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240626120429.GQZnwDzQ47y1fOlFTp@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::35) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ecc7d1-30c9-4583-bc49-08dc9609e027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|7416012|376012|1800799022|366014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlNyWm5OWjZGTC9KQndPU0U1ZzBMYm42UHFmeHZDdExSbnZyK1JTNDRieS8z?=
 =?utf-8?B?aDU0L2FIOFpHWXAyYXhmSXJIQnMxZThHSmxEeE1IdVV1VzY0YTZsQXRlRGRo?=
 =?utf-8?B?TVRBNm1EOXJLS0Y1L1BRV3NBZzc2L3ZYUnAwNmxTZjhKU0tPbDdDalRkcTRS?=
 =?utf-8?B?TlltQ3l3QjZJem5sRTlXSlIxUzJOdGhrUkdudTFVV0NUWC8vdlVyWkZGYTd6?=
 =?utf-8?B?VlJ3ZVhHNDJaYStTRXBkb2N5UVdkQ0hRSGNuRjNaQ1dmeWQvaTV0TWIrQ3lL?=
 =?utf-8?B?WmhmVjU4S1RqTUM1amhpd0hHTCtwV1ZzcVJDK0dDeCtyN3NMeDNHQkRaeTRS?=
 =?utf-8?B?dUIvZWN2OGdpQ3o0cTRsS2dTbG5rV0pHUkRjZlk0dDE4UFRMU1dudU1UZ2NW?=
 =?utf-8?B?ODZFWTg1a3hWdEdNK01PNWhtd1hJVkF1MGptU2Y3d0g3bVNSaWdTQ3Z5RlZW?=
 =?utf-8?B?NkJlekVpejkyZ20xbWxaRm4zZzFjYjlTZDRjSWljblkvUDhNNy9SeGdiTms1?=
 =?utf-8?B?cXh1R3JBcUV3eE5NV3lCdVFMYVo3bXV5RWdXUktrcDRiSmZ1ZmV2RWw5NXds?=
 =?utf-8?B?UUUraGkzQ3l4UkR3a0ttajU0RHdYU3NJam1tK1JrUEpXYUtxOWJqWXhEcGhz?=
 =?utf-8?B?ZGZ1TlRmaVVucFdDR08zblE5T3h0SFVGc3RKQ0N0SHg4NCtCbE9NRG56NWpC?=
 =?utf-8?B?VGloT3NqR053S2UzQkw0R215b2duQUFRdnpkd1pnWUtrMTZmOWo2cU82Nldz?=
 =?utf-8?B?N2MrMll0UlB4WGFMSEdGNnptTmhtN3lSTXdFOWJYT1hQeUI2aEhuWnFtaEdV?=
 =?utf-8?B?aWwydUhETzNGNnVxOG85ckxGSVN4VXJZK1E1T2RIOS94MlBWeTV4WFl6THdu?=
 =?utf-8?B?amNWL0JtTTcvTlVvVmVlSDE5dlc3QWJxWExTVFNBMUphMHRENk16dVBFQmlt?=
 =?utf-8?B?UmE3S3J3aWx2NTZ6MTN1SDhqNDcxdDBFc1hUYk9QblNUb3BsbTZramRSenFQ?=
 =?utf-8?B?V1BSeFJZNVBjdGF3MDQybmtXN0JLdFF2K2djdjU4SWVRV1dFRHVWeGlObm5K?=
 =?utf-8?B?VWFCT2ZVS3lacXQycG5NYXpXSU9OTFJqbStJUjdITW9MaHJxOTh2cTVXSVZV?=
 =?utf-8?B?WDhLeHNPRlNGOFVIdjBzR3pscExPcC9QeDFjY0N4Nk5SM21rTXI2QlJlYUNr?=
 =?utf-8?B?WnptMCtPRUZyMWVYTm9IeW1kL096K3ZLYy9aUjNWV3FOVDBkd0FyN1lBeEgy?=
 =?utf-8?B?c2M2QlhTc0haTEIxenRSU0RzRGNNOE56eE43ZndRYmF5SVAwZlFzak41ZUdM?=
 =?utf-8?B?LzNnLzlEbXBnaG1UaE4relJPRFZFcnVqRVhPQzVCTTZqc1Q3R2E4c3B6bGZ1?=
 =?utf-8?B?UEVVekdmaElHbXRUT1JDSE9uWHhrRlVYUVNld3JIRkwxWVFUWjFORjg5Vmla?=
 =?utf-8?B?RkZmalRyRFpvTGxSVUNGa0VDYlZIbkVtakxHYUdTTGFLYXpHcnpnYnlNS3Y5?=
 =?utf-8?B?bG1ja3J1UGN1cC9jam1GL2hIWHBvYUY2KzhnRFVEZU5uVmJkSUIvVVRxSTZ2?=
 =?utf-8?B?ZWxiT0V1K1laaTF1VkJmUUFjcjZ6Q0NJTnpGdW0yNjZXeW9PL210R0ZXZFNv?=
 =?utf-8?B?VmZ5bHRBQmpNTzFiZk5FdnVRcW9TMXFEZFRkMXM4STZFQlhabCs5dXFQQkNQ?=
 =?utf-8?B?TGJ4WnRaZTQ1UkkvQjlNTTdvTkdaQlFTam8wb0lCeHNyZVhNTG5IUklLTEFJ?=
 =?utf-8?Q?L3Bn+I2jaKS0jfjtyI2HjhT6YSX6ZVE82Hetoy3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(7416012)(376012)(1800799022)(366014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVhxUDh4dVBreHhzaGlCS0hUNGRIR1hyRVQ2eEI0d0gvRE5XUzF2cVYwMWc5?=
 =?utf-8?B?ZkFHcmNTcDFKUWtSQXh4dFBTVUpXZzJIQnEydk9rZkUvbExaUkRPbVQvZTY1?=
 =?utf-8?B?WjE5R1FVcHRHSHdTRHNUcjFydnk0YUFsUGhXRUJMQkYyTjl3TmN6NTBTVFQv?=
 =?utf-8?B?VEZmeWtiRDdJS1ZrckZYS2ZTTVVXb1U0VnkyMGhSMzNZNksxc0pJNFJlWVVE?=
 =?utf-8?B?NU1OUytVMzNJcHZmOTFkajdCdTg1TTg5NnFYN0pYc2paNENCL2xzTWJMZnFq?=
 =?utf-8?B?eU9UcU5nbjV4dkpMeGVTTFRmWVZmSFRoUzNMK0lwdXh5K2c2Rlk3R0hib2w5?=
 =?utf-8?B?WFArYjNCaGxsdXhUSWZmNHBDcGorMVNDMkxQcUp3MFlZMmo2Mm15NHBKc0JO?=
 =?utf-8?B?Z0FJMXhoOHVJUGZnQStaNWM3NDgwRHVVQzBUV0lZOWRRRE9vT1p5ZWdqWUpm?=
 =?utf-8?B?STVrczUwem5BOU9oSUFMekJpTjhlYjB0bmpOYnFPQTRVZ1c4SUxwMnFDbXN2?=
 =?utf-8?B?STJxVktLS1NaaWdZYnJHWFBwa3VKcm95WUdIc0Zhb2w0cHB1UWdBQ3VLS1Jn?=
 =?utf-8?B?aGJMSUpXVjVrR2RHbGdQeHN3MG5pd0JCRDN0bklhWFRVS2ZsR1oyRU52S1Ju?=
 =?utf-8?B?SkdaQjE4Sm5UZ2lFZXNHa2VNcFQ5L1hYTyt6VW9IeUcxcmdJVWhjdlNFZHhT?=
 =?utf-8?B?R0xwVjRVWGRzdVhBM3F1d2FwZ3pEdEM5NjNIdGVTM0luYzFUQzYwTGxJYUF3?=
 =?utf-8?B?QVoxREhnRk5QVXVkUG1aQkZVcGNLOTRsTk1YS3JKV0szaXY1OVJab3NldVJN?=
 =?utf-8?B?UHlHc2NVM2JMSjVDajMyMTNvdGdWVHlEdjh5cWIwR1RkWUp5OHBJWHoycmZE?=
 =?utf-8?B?NjRQY2VFdjB5M2ZSQjdVRFJ2cmpvOHZ2YzRnbGtVWEg3aGNlYUZyQWFOekxh?=
 =?utf-8?B?NTEzVkk3KzNYUnBQOFUrYnZnWUgxRzlSVUFjb3lBZDVQMmJGN2VCeGxFQ0to?=
 =?utf-8?B?L0NwUndLZm8yN2pDcXU2SEpZNEdpNmRYdXpFWkJvZ1V1NEtRVUZkVHduVWNS?=
 =?utf-8?B?S0JWT0tVL2g2ZzFFUSs2YnZZQnoyVXQwdTdERzN4R1N0cU1TczdRd2lXZVhX?=
 =?utf-8?B?TXM5VGs0TjFOQXVTVjB5RHd0ZENpNXE4S2pteFZhbmd6RjV3T1c3OW5VYThI?=
 =?utf-8?B?UDVxUHZlalArT0cwSmEvUEpBOUpyUFBPbzk1VE9YWGZBbkROS1ZpSUVrT0E3?=
 =?utf-8?B?S1l6Yk5ubStqQnlwZ1dhdHpJT2VGek5rTm5PZmxLb0d5VGR4WEZSZlRVcWg0?=
 =?utf-8?B?ZGJLMHVzUWNoUURhY2pKSWtjczJESlRMNGZKM3VpQkZ3d3lrdTJnNHhSQzVL?=
 =?utf-8?B?d3pjV3EzeHVPMzVoaXlCSzMrU2U2SjZ4ZWZWKzZxeWdMUExlVFpBVzg3VnRu?=
 =?utf-8?B?T0w2MWZpeVY2QWluN01Fbmdicm9NY2N5VmhaWHFkMzdLdXBnZjdJSDZ6eFBE?=
 =?utf-8?B?UUhjUjNLeE53WjlVWVFEaEtTeEc2Nmlqb3JMVXEybi8xd1lYOVQwWjZGVFFU?=
 =?utf-8?B?N09WNGRvb05icGFDb1Vob1dWakliUzNYZ0VDNjRiVU1oYmg3Q3R6S0l6dFRq?=
 =?utf-8?B?MnZPd1hjeDl4M3JJSkY5RGhBOWVEbnZGSTNtTk0rREFLQlRkRlBzQmhxTlZn?=
 =?utf-8?B?MlZuR1FPbksrZzhQK0hwUzRtS0EvYW94WEJHWmhKamtKMkJDSytnaU0xQWRr?=
 =?utf-8?B?emxxWEJsSlRwVVJ5N1NrVEZPN0ZZYWUwZFphaHJZNUZhZWw2T1VGMXFUNmhZ?=
 =?utf-8?B?dUNCamVPQU5RZ3QxcHpMU28yMFhQWUxHTWgzaVQybEJXaXNVWGFZTVZyTXB5?=
 =?utf-8?B?OVdGT0NpNFR2ZlhlOHpHUWd4SDRUdGd1M2RqRmljVHl1czBVVHVGbW15b2FN?=
 =?utf-8?B?ME5ZeFhieFRJYWVTWXlFSm02NHdQM25yVFlYUlV6akdWQVh5RUFnUWhQcHJk?=
 =?utf-8?B?ekxSRnlpaW5xTGlFQWcxcEZySStXdDZsNjBBZDc2U3VnMTFQT25pdTVmNXJO?=
 =?utf-8?B?VEhUcUxLSDh0d1VMYjNzVmRJdlNwWk02Y0R2aUNmdHNmK2QwQlRhckE5MkhB?=
 =?utf-8?Q?tpPYwUeFA1Q+hSG2Kh6w+yyS9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ecc7d1-30c9-4583-bc49-08dc9609e027
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 18:00:34.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGtHvxVmCygnZEnm5WsP3YIbTqKpmPphpWZ3IjGtPdRXu5Rf4NkQuSybWcCGKgB8AU4ULEnnxECQCOLSA12mgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304



On 6/26/2024 07:04, Borislav Petkov wrote:
> On Tue, Jun 25, 2024 at 02:56:24PM -0500, Avadhut Naik wrote:
>> From: Yazen Ghannam <yazen.ghannam@amd.com>
>>
>> A new "FRU Text in MCA" feature is defined where the Field Replaceable
>> Unit (FRU) Text for a device is represented by a string in the new
>> MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
>> bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).
>>
>> The FRU Text is populated dynamically for each individual error state
>> (MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
>> covers multiple devices, for example, a Unified Memory Controller (UMC)
>> bank that manages two DIMMs.
>>
> 
> From here...
> 
>> Print the FRU Text string, if available, when decoding an MCA error.
>>
>> Also, add field for MCA_CONFIG MSR in struct mce_hw_err as vendor specific
>> error information and save the value of the MSR. The very value can then be
>> exported through tracepoint for userspace tools like rasdaemon to print FRU
>> Text, if available.
>>
>>  Note: Checkpatch checks/warnings are ignored to maintain coding style.
> 
> ... to here goes into the trash can except what MCA_CONFIG is for being logged
> as part of the error.
> 
Will do.

>> [Yazen: Add Avadhut as co-developer for wrapper changes. ]
>>
>> Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Ditto as for patch 3.
> 
Will do.
>> ---
> 
>> @@ -853,8 +850,18 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>>  
>>  		if (m->status & MCI_STATUS_SYNDV) {
>>  			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
>> -			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
>> -				 err->vi.amd.synd1, err->vi.amd.synd2);
>> +			if (mca_config & MCI_CONFIG_FRUTEXT) {
>> +				char frutext[17];
>> +
>> +				memset(frutext, 0, sizeof(frutext));
> 
> Why are you clearing it if you're overwriting it immediately?
> 
Since its a local variable, wanted to ensure that the memory is zeroed out to prevent
any issues with the %s specifier, used later on.
Would you recommend removing that and using initializer instead for the string?

>> +				memcpy(&frutext[0], &err->vi.amd.synd1, 8);
>> +				memcpy(&frutext[8], &err->vi.amd.synd2, 8);
>> +
>> +				pr_emerg(HW_ERR "FRU Text: %s", frutext);
>> +			} else {
>> +				pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
>> +					 err->vi.amd.synd1, err->vi.amd.synd2);
>> +			}
>>  		}
>>  
>>  		pr_cont("\n");
>> -- 
>> 2.34.1
>>
> 

-- 
Thanks,
Avadhut Naik

