Return-Path: <linux-edac+bounces-2085-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD7999F4F7
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 20:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DC51C23181
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC91B1FAF17;
	Tue, 15 Oct 2024 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3u0Fm/Fn"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362F38DC7;
	Tue, 15 Oct 2024 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016050; cv=fail; b=dgx00VmVRXXOtEZ0Op3yh2iPqswE/Iv+ZYGwJDKc28mEWI66PgQjBxTlh9j6nyKHpmMQXhr1sTGrpxlhTEe50+0EOD4sZfoj9ya2qPR8HNOSJA7FNAf16Xh2zn9wZ2QtVB3rpEd3MOK8mK/xRR/IaHzv9Cjk0HCmhpUGriMcuRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016050; c=relaxed/simple;
	bh=Pvb+cMJSyboEfXXaDvmpoQ3Ez5b//E/m36K2vm/W2gw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V19rxKJW3fsAbt8gX1qaIocQPwKax+Ch+/NzPCpUR+1gliiMeDLvrHh5il6ks1g37Ij9Zx6+gVHI5/0OmXT3/jk5Ku3cS1XvvXZdAjvJF9bRemwefkjAoq6MJDAk3Pp9Xyv7BNhB0j0lfo7QYPrllhQyMfadZpEisZx7r0W/E3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3u0Fm/Fn; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ns734GobNNbzUbbCCD26hpKfu3U7KDdwoU7gKAWhI05mFrUXt3NxsTJYiov+mkEit4rEHArft9Dg4xrc/6gRJIyPCXBFKl835lsMQYTdIDViapWoeaIHvtB6/DvYY7W0H/l8EYU27a5TN35d5aM4+x5/9s2pSk5gKwxpLjHKlhwji7muJ8MXXtYPHcuQmZWCJwSpiQsmPxIYvKuu3bWS0qnyyyXA4OHDMj4kLtYcfUqgXJAeXz8Fe9NiYtCC29ZLzbZ9AGe2J+pqnaDFRxHgK3GAqMZzHVJ+4bfmzISZFz1QNmtFiYR0B0rsTtjLPgwaZfs/+lOnsAPfhieh59cOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdZeVCeqnpiYmiIxoQ/TRj/jP+46CNc7k/oAm8SgX34=;
 b=S2HZRqDvcSXTjOtUfYO0yo6G1cCjoTAVBrTJQHQnbvV84lZ2vrq/fVfF/zjaW9eOx15jRCbiMFkxW/dDrKoMn61o+26GF3NLeZ6FrCokiEAYKg8Dh8Dne0e99aHZw11QlXM2mvrO5/xYqPF6tN4s3Rk+gVAXXALYs01EzXlEN1aeqQRIQEuKhBQk5jFJDeS1lYEQ6uMtfUQTWUuv5dLl6ei0zmho4IhtzKVHGjYDzAxpasQcygfilEUausNz2Y1vnCYGlb/DpDUL5RNiW4hVyedJ3/WgDTsgZbosIDAraNcwMfp8MyPzl/ozEXXux0j1RE0rF46rWO9M57yjXudNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdZeVCeqnpiYmiIxoQ/TRj/jP+46CNc7k/oAm8SgX34=;
 b=3u0Fm/FnayPMn+mt0c1euHovQoCfzPJdotUeK6AAKxMZkq/46ixkFRlCYd8AVCUQjenFRmZIsIOu+brAZuHVqCCAvTv/NL1knmKk04ilrkCgXNroWal9N5izX3HL9hrnkSKI5ovwJSNJNxUMm3p46cCTQSjsqAyg6Vky5rAdmog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Tue, 15 Oct
 2024 18:14:04 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 18:14:04 +0000
Message-ID: <86df5bba-1750-4dc9-ba3c-b357f562748c@amd.com>
Date: Tue, 15 Oct 2024 13:14:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Avadhut Naik
 <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org"
 <mchehab@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 "john.allen@amd.com" <john.allen@amd.com>
References: <20241001181617.604573-1-avadhut.naik@amd.com>
 <20241001181617.604573-2-avadhut.naik@amd.com>
 <CY8PR11MB713406B2C492D55428397AFA89452@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <CY8PR11MB713406B2C492D55428397AFA89452@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:805:106::12) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: dfade003-35d1-4060-0f46-08dced4526cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2ZDM3pjQllReUV2R0xKNGJiMy9FWmVvTW5mcGRUaEtEaGUzekpGcE9tSWs1?=
 =?utf-8?B?VnNoVE1MNEJPL25YTTFUTUF2bS9JL1pqenNZa0NnSG9Rdk5nZXZoblAwdUox?=
 =?utf-8?B?diszZDZJRGZoYmYybDZIWS8xNFJES3dMdHRxWnJQZ3NBbmM2MG9sWlh3dkx6?=
 =?utf-8?B?THlrTVRaVUQ3RjdqUDNzV0VOTUlaN3cyeVpmOFEzMElZMlZibEU3YU1JblQ2?=
 =?utf-8?B?MEJVcHNZdmJwaXlsWDlnbnQrVlFsY3lhMUZoN2FUQUt1bmtqMUttSDBpVFp2?=
 =?utf-8?B?RjVzeGliL3RCeVF0ODhZV2xRUmNpN2FCS0poU1ZMYS9wNFFpd0lhVmk1UXp4?=
 =?utf-8?B?Vko0eFdLV3Q0R2ZCVEZ4aWdHTXBhRDc5dHNTZC9Da1RyaS90blBRb1VsNitw?=
 =?utf-8?B?T1VKZEhXZlhiNHB1ZkM1ay82Y3ZhTFRZSHF0OENnSllmd2NlVkZQcGZIR3N5?=
 =?utf-8?B?SktPcXZBOFVjQzdDbndjbVlUOVdPL2xrZncwVk93YkE3dVUzU1RMbmU5di95?=
 =?utf-8?B?dkZOVUpveDZmTng4bFRzalFjN0RtalcvOHFLWjlmM01EcTBxRzcvWkVqbHds?=
 =?utf-8?B?WUE4SG1SRUpGM0RGNFhXVGxkL2ZIblBFb1hGOEVkNVZJeHBDbXVsQ1A4U3F6?=
 =?utf-8?B?M2tOeU1mMmh2NnRvRlJzT1UrMnY4THc4RkVPYnJDN2luMTdDbDRsK3dhVUVC?=
 =?utf-8?B?dHJzMGJYM0FyY2N4OWNGTGZRdTB5dEpMSHU3Z3NycnJGcEFPbTh5ZmU1d1JK?=
 =?utf-8?B?L3NJc2xVZ1lvZjRCdk11MjloNDI5eTBwK0MrRjdhY3JmaDVqZjRoNDVWTGJo?=
 =?utf-8?B?cUY1ZmxFNjFqNFNTOHpHZnBlSGhvV09CUnNjaUJtaUticm8xWGNJTFlMNENx?=
 =?utf-8?B?QVE1ZTQrQnc1RzY3OE1JWi9JVGQzRllxQ1ovZ2RNMWpFdVlITDNwUS9oSXV4?=
 =?utf-8?B?U1ozWldvaG5tb29JZkxmUGEza2lXY3lYVWxhQXBUVVBvMkJma3lTNWhQT1Fn?=
 =?utf-8?B?bVFOTnBheCs2YVVOczIzR1FyS0pDNERlRm02U1J4VEplNDlGKzh3dHZpV2x0?=
 =?utf-8?B?QjF3a1NaRi9VTUpNQ0E3ODZqR3pIYkZwVGNVSTJ2OEFMQmI3MmxPNkFtbWVN?=
 =?utf-8?B?aHJLRjg2VDhlK01MN2gxZTE5RjhQZ29MTnJHTk9tVGJkRXFuS1NvWXFGU1oz?=
 =?utf-8?B?eUNIUElEd3UvN0NZWmJRZ3dScU5GMGh2RDNSYUFjVHp1ay92dElYZHpCa1Qv?=
 =?utf-8?B?N2UzcVpYb0FONXdDY09KWXNlakNoYW9ybmZhcUJNUWpwMnA1Y2w3cU56M29k?=
 =?utf-8?B?WXdrNldoREsyMzB0QzlGVjlQS3RIdm1CZTE0b1ZMeE1WdWUyV2tOTVlEdW5I?=
 =?utf-8?B?YUhhR3dMenVPaGxZLzNjbDdsOUxsVkRYV0s2VEZBQ1RXS0tNRTdsOFBIb2dH?=
 =?utf-8?B?MGVBUERLUXgwZkpiVC9uU09ZUE9ySHhnclU2RVk1ZW1Ga01lckJBeWZNMmZE?=
 =?utf-8?B?dWxvRTNqU080ellCS1lRT1V2NmRmdlNkTlEwalQ1MFRxeGsyTzlOS2lOVFB1?=
 =?utf-8?B?Rk5tMmpveDN0TnJPSmFQVzNKcFk5cmJmcC9qT3Z4TXBOYTVCNFNPS21PYWF4?=
 =?utf-8?B?QTVhdWJ3S1N5UlZxTGdGcmZxRmtLa0JGYTlCTXFBVGt5VGF5YW05dmxyRE00?=
 =?utf-8?B?ZlpqVVZCZWZhWXJ3UWxYdjBBMDZlUytaOXdDRm1qL1MxRjJHRlJhOWJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkprZmVOckZUN1FjMmhLTVB0MjdjMWdheWk1QmEwQVRxdCtjd3B6cjk4bVlD?=
 =?utf-8?B?K2g4ZlRUVkpCNDVvcng4TElrNWR0VWttV0lTamNsckM5elZaQnVJYVgyYXkz?=
 =?utf-8?B?NE1GbUJvUndHYndYL1laZ21KY3d6Qll0LzdLQ0NPY3RiYjhnNnk2Tm1oRzlq?=
 =?utf-8?B?NnBOcGVnR01yUDFzejc5RTJuMGZJTzFqT3RubkpXVXhkQWErc0ZydXIvUm45?=
 =?utf-8?B?UytWYlBxbDVDclY2bDRIc1BRUTBpV0JJeHdSSVBYR1IvaXhqMEpmV1dkejkw?=
 =?utf-8?B?MmRySkJXbTM4K05ZTFZEcVQwei9UQVdlalRRVDI4RVloaVhId3g5MzJEZk10?=
 =?utf-8?B?cUdYNzg5TXhOWVhSR3VkL0IxOFdwNERXWGJ1bVNjcWJpWmpoYmZEcHlWbE0z?=
 =?utf-8?B?dEZVTGErM202Wkg4cmkwRmszQ1BBbmRJc3lqcTlXbGM2cUZ5cHlZRUFpakZH?=
 =?utf-8?B?bnZiVnZwVjRJUHBxS1VEdnRjV3QyZVMrTTl6a05Eb0pDckQ4SUJSSUdrZTdk?=
 =?utf-8?B?K3Y2Y3gxNlhHZ1p0WUtML2tFU3pMWGR3R1BwS2FYVVVkblJRaEdpVEtJU05z?=
 =?utf-8?B?SXVuZGdvVFZJekRmK2U2eDdCTTBMZkh2YzByQS8vckJjVDBEQmIvUXRVWTVS?=
 =?utf-8?B?Y1Yvd0hqcy9JRzdyNXZYMTdsT1RudmhPMVowK0oyOEVlWDU5alRsNDdCMHRa?=
 =?utf-8?B?SUFpN3BhdHhFbEdtbHYzMzhxT0ovci9Tdk1vVDVOd25hWmZhS3V5c2pUc3pD?=
 =?utf-8?B?NjZjREI5ejc5WkE0VzlNc2c1UXByK3l3Uk1DYUhrdklKT2p2S0JwWHdBWFJB?=
 =?utf-8?B?djErZi9iajZsa01ua09Sd1dadFV2Z0R4cnBXci9pMlppa3NsM2lJTG5xODQ3?=
 =?utf-8?B?Q3IwdURIWEZmcHFnaW9IcC9vK0NOeVhKZTQ3OWpibGY5Ym1XNDgzVCtSM0FO?=
 =?utf-8?B?THdoQzBOSUJWUW14N24zaUJDT3lBbEI5TXhvVEpYbHdRYVhJMXhvbnhKT1VV?=
 =?utf-8?B?L2lVT3hGeVBPSlVSeDhBN3VkOFN1STY0ZHVTbUxHSjYxRmIrdlhmWk00ZzBh?=
 =?utf-8?B?bTY0andzYVNxMDBIU0M0YjVNUWJIMGFvaWJrRkk2TEpRNDJHemI1aE82YlAv?=
 =?utf-8?B?bjRGNnBCb2JtYXlucS9qSFV5K0taZldkL1pNVkJNM0x2dzRaTThxMS9WQnNw?=
 =?utf-8?B?eUR2eENQSEh2WXJvVVZSblNUOTRVMVZOYk5FV3FLU0EwVTI0eUxKQkw5UUZE?=
 =?utf-8?B?aldLYlc1ZnRUaW1sdCtScTA1SFR2Ni9heklITmxXdFlHVGxLS21tdUUzNkxk?=
 =?utf-8?B?cXhRYnBXT2dHaXhPK2hXNGd4aExKalhkeU94aW94cCtrdXI2bTVOYlVtRHFh?=
 =?utf-8?B?VWJQbWZMOERTdEFSUUFCVG80YW5uTEhuaFRDMzkxeWhGenF4YWlMRjNOQkNj?=
 =?utf-8?B?MHFOdDRROS90UmlZV3Q2c2lYbDRYTlNvajA1SGF5Uk1iZCtDMjg2Z1hEK1l5?=
 =?utf-8?B?MlpEMlEvdTI2eHJzUC9kU1RtRGh0MldSbDcxU1VscThmNnVFT1lacmh3eFN4?=
 =?utf-8?B?K1lVQ3VuR0wveS9QOW9uV3BMSG1SYW1ZMGczUkhrblJkSkZpb0EyU0FpbDFN?=
 =?utf-8?B?OXREVjJQeGpOckV6c014d0xBZkREbWZZdXJudlNCZHFleEtBM1dFc1B4WGg5?=
 =?utf-8?B?SkNGbnY2OWdSZmVVdmtHdkFEaXRxampPVzk4MnY0K1NYUWt5YXlTRjVFMmJG?=
 =?utf-8?B?dCt6UnFMSWppZDFMdnEyWEtkWjhKYlYyQnp2NGUyTEpWRk5VdDJNblRFZS9q?=
 =?utf-8?B?ZGwvU01jelpzYWF5NEFqRCtrMmFvNTc3NHZTem1pZ0tZNmxqUUQ3MGVRRFRI?=
 =?utf-8?B?bGcxNDNUdHB2T29jcHl1M3B2RjZVc3RFU0UrMUQvMFhUd1V1QW1sU0NnL0xu?=
 =?utf-8?B?RGk1dU5ydVo0bitFY3Jlbm10cTBoMGJuaFdidXNXRlpldXNyL3R2VXFJM1lN?=
 =?utf-8?B?L3BFeU9SVXNrQmR1aDYrL0dTeGZUQ1BQcFF5TWc2am9yMVdZT2lZeHBEb3BD?=
 =?utf-8?B?b3kzNzRIRlVhdFNxK1UwdTBxVFZyRTFGY3BEQWwrRE5TU21VWEdKN0NMbGkv?=
 =?utf-8?Q?MiIc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfade003-35d1-4060-0f46-08dced4526cb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 18:14:04.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9D5QwBwvJ9tXwESpj3FiuE2Q+Ze6Dg0VpmzD4tAcqAVHLGMSBI9KD0SFqA5aCl5Meb3L133uqFaRZOSinXmeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148


[...]
On 10/15/2024 01:53, Zhuo, Qiuxu wrote:
>> From: Avadhut Naik <avadhut.naik@amd.com>
>> [...]
>> [...]
>>  static __always_inline int
>> -__mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
>> +__mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs, struct mce *final,
> 
> The 'final' parameter should also be a pointer to this_cpu_ptr(&hw_errs_seen).
> So, it's the final value with an entire 'mce_hw_err' structure stored to 
> ' hw_errs_seen ',  not just a 'mce' structure got stored in 'hw_errs_seen'.
> 
> So,
>    __mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs, struct mce_hw_err *final, ...
> 

Thanks for pointing this out. This may require a few other changes too.
Will address them in the next revision.

>>  		unsigned long *toclear, unsigned long *valid_banks, int no_way_out,
>>  		int *worst)
>> [...]

-- 
Thanks,
Avadhut Naik

