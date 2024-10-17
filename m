Return-Path: <linux-edac+bounces-2130-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A009A300A
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 23:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DCC5B22C90
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 21:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6CE1D63F2;
	Thu, 17 Oct 2024 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="46194N0d"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511A71D618E;
	Thu, 17 Oct 2024 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201770; cv=fail; b=gvsV7LiHB6mJ2A6tsG8XZip6RLegj2RrskCg5/hTA30/fuv4eUo6UkIPIj+7NfIFzBebg4ESU1/+v18Qzz+qDJn3yvvQPekNW2qRIKEunvI0qFKWVrCxR8GaLsRxKzzJusOBfmSCxSK2mzJg4JvVR9PFk4D8qoZFdgn8WlP8Bz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201770; c=relaxed/simple;
	bh=BBTLutipmFx9YX00E/7LkCDYU9kmFkTA6p3lms2ZrJo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KPM/kCi3PA+alvZ80X91vZ1iQaPTONXVT7BTWvRmULoLMuXBXoIeBMPpL15Jm0ZH1bcnChJx5O+EyCZETd0S5pFqZzBsDPUDHWbaqwxHc7a+lTCSxYXltltxK7Dd+ZrTUrTXNhTgSm8VvkEYk429OJIp5XShHxMSI4krn7iaK1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=46194N0d; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsGk1VEzUgnbPExpJaayeCUosmgpIlISThQoyjTS+SOfEH+FPouva3/JRoS+oxC4ELIyHspLTlvr60rdgnPTzhYx7cUdf/CP55rmcvTKSBCQqihkf12fBno6IiN3gwSDxvRl7irrYTbn3kFRNJSmelM0EfpY0OmKk7b9D4bSIKwrVTR515I44VcmPMeJZnSp0ql60X7Q4LVjkXHk4xcdpaiV7VUgTWDTPHKZuwyFlnUx+llqx6m7U1ziFsuNRri4OEz2U3fpRNkw4Jx4dRJ8K1u74Ts0DvykUXVpGDRaN1uNj0GhKl9ayNet9SHUbyDszjKZS5oo8FNzpPbYD9WrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgbrXrDn5I5GB3TMqHCONFhbVD+R9vJ6m5hOC+QjjnI=;
 b=KzPrbZMWMX38KKkOFOi1NfQfE06MN/vQhi5mdM+UhYJuK/SXfpjFkL796SWKk+ntn712TOcu47BVpw4AmD6C5DEQ67/RdcIS72OUMOiA68hLxFpjsCtl/Cfwd5PaHduSS3Olk8XbBuNIxg7L1SRbnn8cz/Cem6tZDBVoMRf7E4fGfz8uPFnftq1i/S7bQyaB1XpjBbtzxjU7C1K3ezbngv3E8BlPurSgYRIKeTlipNKNMrwm7sWof7HZpiZ7/6MGFpnEr3m/lyGqhmWwiZwx0OOevxybdA7IBBNMfLN9JYK3o/VDiS4VQn2DA+4FGc6ukKP0zRR2xlfhStRCur6SOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgbrXrDn5I5GB3TMqHCONFhbVD+R9vJ6m5hOC+QjjnI=;
 b=46194N0d33g7uaNAhYeX5NXnDzfPYUGbwRg51tXlMU2KsSq6sie/ZvRGqlaDuFqj7si7XmPObe6JfhmEiCtrA3+2MGklu2+EBIljursJ02L98g4Vq0QIN8OJ01U4TyUPv1J7OCerjQwqUnnfUdZSf7Dt6CGt00yBLLOO2Cn/gLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 21:49:24 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%6]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 21:49:23 +0000
Message-ID: <8c71d83b-4dd2-4411-aac2-81284bf3a9df@amd.com>
Date: Thu, 17 Oct 2024 16:49:21 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 3/5] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Content-Language: en-US
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 "john.allen@amd.com" <john.allen@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
 <20241016064021.2773618-4-avadhut.naik@amd.com>
 <CY8PR11MB7134178B954B4DFFF6AEF81689472@CY8PR11MB7134.namprd11.prod.outlook.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <CY8PR11MB7134178B954B4DFFF6AEF81689472@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0052.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::28) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: fd56e83c-bf7f-4ee9-2f8b-08dceef59026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0I0RGVKTTNiTDNMMEFpYkdrbjFOc1BjQ29CaEoxWFJPOE1FaHB2UC9ONzk5?=
 =?utf-8?B?bWtLOUJvVjFUN0ZtQXJzT0ViQllmNWdQNDZTbis1ZE4rY29NWjM0TC9hU0Ux?=
 =?utf-8?B?clFoRnIrSkhKd2tUZ1ZWMzBxdlg0NG1ZeVhFUis5UEQ4T3N4YTJBd2FPNGNU?=
 =?utf-8?B?aDZVUVQzcXBQQ3JsL1lVWnptbi8xZTUyWlFRRTdCMnpVNE96NkQ2QkhvL1Ix?=
 =?utf-8?B?SnRxTHJSN2psdE5pZ01ra3pudmtJYTBBaUt6aktxYWptMGZDa3UzUmlQZDhm?=
 =?utf-8?B?QWpKZlMvUklKT0MrNm5EcWNHTWVldjRlMGVnTzhLWW1oOVZQVFZXeWQxU3Mx?=
 =?utf-8?B?eFBVRklyYzU0Y29tUjJJeWJVRmp1bVFqYkc1RVIzSFJyOUpwVHY2WUtJRnhi?=
 =?utf-8?B?K0dwdkV3Y0tmUTlSRXhhbFNQd1RDQkhaQWZZOVFoWTE2bVptUmtoYi8vTHdj?=
 =?utf-8?B?SERSdW10MGxldFIrdWF4T1puS3hQQTF6YjAwdmJkenpvZXc4Z3VLcWZOSFlw?=
 =?utf-8?B?Mk5WQkFuaGhHM1p5bTBlR2JjdFBkbTQ1ME05NHdaeVFzNko3bE5PWm9CNThj?=
 =?utf-8?B?dEZ2U2IvM3lOcmtyQy92TzNGSEFTK2FTQ0prcVU0WDhKa05rMUhab1QzRG5t?=
 =?utf-8?B?VXVlY3IzVkVWOEhQdlVxdDN3VHZtWTJkYnp0b0pSeVhZK0FZN1MwRUVzS1Nl?=
 =?utf-8?B?aTFpcmZDNE9sRHZzMXg2dzdaQ2F3d3UySGZpQ2VEZk1rZElUalYxKzFhU2VH?=
 =?utf-8?B?R1R0UTlkRWQvMUFUUlcyVVAveVhWWEdoWU80RGFZb2kyZW05Zi9VbDBlRUNI?=
 =?utf-8?B?aUlSYXlJRWN6OVZubGFjQU9EakxuLzh4eWJBbVJaeUZJbk8yOGxOOGNuZllS?=
 =?utf-8?B?M1VoelhZVzhjdXFZMmJwSHBNLzJ2VW5laEdIUG9rVFdrbkoreEduZ1UyM1hm?=
 =?utf-8?B?YlhETWNvS1g2UTEyYmJEenF2NCtuQ1pPSk1hZHM0bDQrU3o0UXZJNDIvYUNS?=
 =?utf-8?B?UzVxRWFwcGIrQVVuSTQ4dU1LWWFMYnRMMEwzMEplUS9yQ1ZaTXViYitWcmxr?=
 =?utf-8?B?STNWYXlRNk1IVnNvT3lMMXh5SXdiWkM4cnYyNlN4ZE9KSFhUV2Irb1ZNcW14?=
 =?utf-8?B?ZndnNTlNVGFBMVN3bytueS9QRkQ1ekx3ZmtpQm5EYWNvQWVLUkhZWmR6a2RS?=
 =?utf-8?B?NGlmMXFWZkdzK3FXekJ1L3FVdFRIVjZZTDFsZGdkQS9BT2JaZjBaWW5taE5t?=
 =?utf-8?B?N2dxNFg2aTVyemJBNG4xTFVFTHd4dWVQRTJIS0JXSmZvd3NZalMzMTNwS3N0?=
 =?utf-8?B?V2xsMVpqYzVNT0kxT0dlQVc5bmJxZEIxaUcvWTR4cnpRMnFLcnhkNC9ITWtm?=
 =?utf-8?B?aHJpNXVhVjdEOCtqdncxTFpmSitadlE3NmZRQkhjYzQ3dEJWTWgrSU0zUGFq?=
 =?utf-8?B?L29kWlBvVHhCSjdVazMxZUk4bFZwa1pqV2NmOUR1TFJVN3EyOXJLWXZrYzRC?=
 =?utf-8?B?amFDUGxKcUQ0TVJrZnFJUmxkdFErM1V4aC9KVnNqRHdSRk9oODNhV0lTeStP?=
 =?utf-8?B?NWl5dmdkQlh6dXZoM2JCT1dKb0tFaFpuNTdxdmhQTlNBNnpNek5xSk1GYkJJ?=
 =?utf-8?B?cXZhUmFJZW0xSkNwdS9mZm1ZdnZ6MGw1UHJHTUc2VjdKanBLQTRVUFVhUTNi?=
 =?utf-8?B?eUxuL1liUlNvNTVDNUJlNVZmZTVkMlh0eWUzQjVxQ1ZzRVlaYlJtODZiNWpL?=
 =?utf-8?Q?R5rHSGzWUN29RtTnZRk5t8Cp2K4Y04pArrjyqkr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjgrckV5WUQ0Yk42dmIrSGxXRFhNM0NUSEdWWGJ0dnhqcWZOTXplKytONGl3?=
 =?utf-8?B?enhqNS9BaHlmZHh3SjBGRUVvMnlBQ045K3YzN2JrUkk4cmlvL0N3Tk52Q0Uw?=
 =?utf-8?B?WVIxamxJM283R2xvd3NZaldVS29qR0NIaUx1ckdiTTNyS000Vnl5MzNDNVlT?=
 =?utf-8?B?ajd0aTRaUTAwSHdUbDdDY3duUnN5dzgrV2tmbjlSSmp6c1lPaFR3b2FwckNC?=
 =?utf-8?B?LzBQandUUlhWZTFLK3BFZCtEcFk2TmJrQTJoR3YzS1VYZ2t1bjdOV1ZjcDVE?=
 =?utf-8?B?L2ZJVU1pU3ZkKzMvWExaOWowYm9qWUZ3TTlxbWJaWGVaMm9FbHpzSjBmMjlY?=
 =?utf-8?B?Qm1qNHFUYUJHSFNGcjBadkFhNEpaMHJxUFRmd3NrOXo3OUF2N3FDL2JyUEk2?=
 =?utf-8?B?WVMyOWhLbExYcWNpcVlOWXNMeFRna2pDUWdYK0JMNURaVGpmbS9QRmV2Uys4?=
 =?utf-8?B?djJZSmRFb05vS3VPOWY4a0hOdGFDVEFQQ0xCc3VoMC95S1FJclpSM3EvL0Jt?=
 =?utf-8?B?QWhqU0RDcDNHS3VZbGJDTytBYklpOWFQNUFSVFlRdGc4dEdnMURPOElKaFly?=
 =?utf-8?B?YjJ1Y21vUDRrNkpsc1dVNSt0YTZUTWNldFFPQ3U2Qnl0WHJGeVhlRDkwd2tu?=
 =?utf-8?B?eGVYbGNmOXEzcXBuMXRyU20rYThYRVowSDYxYlVualEya0dNMHRJSVRYdDFE?=
 =?utf-8?B?SDVDU244ZVRPSmtEbWxjaEJsRjVDanJQNnN0REJvaHdrZ0cyS2xFZVVDZXUv?=
 =?utf-8?B?N3FoMHVpL1BoOW1nZlZNYnZQMFNCK3ZnZmtHNXF6TGovT0NWSVcxelJaWTJN?=
 =?utf-8?B?QWUvZVE4ZWdhdEtCMmlMUzJxNk1nditGSUFObXczTjR1QVNKYkRVZWlWUytL?=
 =?utf-8?B?TXZ4OUNGb3JDM21hRlJjK3Frd3lROVVTeHlKVkwycDZ2MlluUUpJaEg2UTVv?=
 =?utf-8?B?aDV4M2FJbWdmMExGRjc3b0h5dFBtd2ducE1BbG1QK05WTzYzNW1JN0c1eWtD?=
 =?utf-8?B?eDZvb1FqbjhueWswbkRIenIyTEhWN3pVbVlBRkduODNDS09FdzYxeTFmVWo3?=
 =?utf-8?B?VjI1ckRQVGUxNXoyaDBhaTc1aWtpam5vSVJxYnVDRWFnY085UVhqUDZVM2wv?=
 =?utf-8?B?dU42a3JvRVVrNHIyQmxFU04vcGNKdmRzNnlpNkV5QmZzWUM1b0dSWSsvekg1?=
 =?utf-8?B?cVFiUkZKRFNJVFlYZ043QXljK2RxQUZMblFXOVBCWHZhT05YWTlFVWhFbHBG?=
 =?utf-8?B?UExtU1RIaGNvTFdQMzE1WU4vL2JxNHVXRWdqblZZMUhsRitzRzhtdUw1NTFo?=
 =?utf-8?B?Q3ZGTmJrZVQzeXVyVlBJUmRiZGNsUkltY1BNdkN0SXJlTnhZN3BUakRtbHoz?=
 =?utf-8?B?MWViUFpMZzlzZndsbjlCWUVHVGZJd2FmRk5BR1FkTi9TMnUwNjJONksrR3dU?=
 =?utf-8?B?WU5taFhFN0ZENjRNRnZNUWxqY1JUYkFIeWhEaGluQlZNMXZDMHdxUUx2dWVO?=
 =?utf-8?B?cjRHTFpuQmpoUTBDMWhjNFBZbi9oOGhGdW5qcUUyanNGNlovcDlpZzJBSzBt?=
 =?utf-8?B?TlJHMDNkaW5RdmxvTndJdTU5U3N4VjhZRE8vYkp6ZGQxNWorYitlNmpnMWlQ?=
 =?utf-8?B?YkhvRGg2NHRuNjhWYmNHbkVXbjZkZ2hPdzNzUFg2SFhOaXZqUTJ1MUo3V2x1?=
 =?utf-8?B?QUUvWkJaVksySERkSngrN2JzVEs1S0xmS21KaEUrdDdoZnR1MFNNOWdtb29Y?=
 =?utf-8?B?NGM2S3lBSXZleWJuMzRFRkdtQ3l6TTNFTGpMRk9rSlppd2hLWFRackhCa0hS?=
 =?utf-8?B?OThHa3J5RGtsTlc1TmZVcGVPc2NMYktody9WWDg5WXRhdUlDL2hVKzJ1SlJu?=
 =?utf-8?B?NjNxbVh0cTNtd0IzNXJRKzZBUzlOV09PVkJIVDByOURuc081dVJNZGJENmNh?=
 =?utf-8?B?YmpmRnJBclNBNkxheFQwTlExUWkvNEphUTBNWmdrOXlBTTNyRGhqQ3Ayd01U?=
 =?utf-8?B?YVdFRVp4MUlGWUpMN2p0SmpzQnN3MmU2TG9WeE43OTlvSm95djZtQllXTU9Z?=
 =?utf-8?B?dFhWTGV3QnY3RlFtSXd5ZnRmWkJHVUNudDRQeVp4K2M2cG1zVzVBTFN2enRB?=
 =?utf-8?Q?YoOFJ+OPc1KSTZr3chiP7AZtb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd56e83c-bf7f-4ee9-2f8b-08dceef59026
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:49:23.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbRVW8KJpX5oxCpPG3YknrqILyRxcfkQkQV3CfZgp3mrXA0MwV0gasL5bMwlg8DsZg/8xn/I3maN9X2evLsmCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579



On 10/17/2024 02:09, Zhuo, Qiuxu wrote:
>> From: Avadhut Naik <avadhut.naik@amd.com>
>> [...]
>> --- a/include/trace/events/mce.h
>> +++ b/include/trace/events/mce.h
>> @@ -43,6 +43,7 @@ TRACE_EVENT(mce_record,
>>  		__field(	u8,		bank		)
>>  		__field(	u8,		cpuvendor	)
>>  		__field(	u32,		microcode	)
>> +		__dynamic_array(u8, v_data, sizeof(err->vendor))
>>  	),
>>
>>  	TP_fast_assign(
>> @@ -65,9 +66,10 @@ TRACE_EVENT(mce_record,
>>  		__entry->bank		= err->m.bank;
>>  		__entry->cpuvendor	= err->m.cpuvendor;
>>  		__entry->microcode	= err->m.microcode;
>> +		memcpy(__get_dynamic_array(v_data), &err->vendor,
>> +sizeof(err->vendor));
>>  	),
>>
>> -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx,
>> ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx,
>> PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x,
>> microcode: %x",
>> +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016llx, IPID: %016llx,
>> +ADDR: %016llx, MISC: %016llx, SYND: %016llx, RIP: %02x:<%016llx>, TSC:
>> +%llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC:
>> +%x, microcode: %x, vendor data: %s",
>>  		__entry->cpu,
>>  		__entry->mcgcap, __entry->mcgstatus,
>>  		__entry->bank, __entry->status,
>> @@ -83,7 +85,8 @@ TRACE_EVENT(mce_record,
>>  		__entry->walltime,
>>  		__entry->socketid,
>>  		__entry->apicid,
>> -		__entry->microcode)
>> +		__entry->microcode,
>> +		__print_dynamic_array(v_data, 8))
> 
> What is the 2nd parameter '8' about? 
> 
> The 2nd parameter is about the element size. 
> The element type is 'u8', as defined above. 
> Therefore:
> 
>     __print_dynamic_array(v_data, sizeof(u8)))
>     
> -Qiuxu
> 
IIUC, the second parameter above determines how the dynamic
array is parsed and logged. The value of 8 means that the
array will be traversed with a u64 pointer i.e. data within
the array will be logged by the tracepoint in chunks of 8
bytes. Something like below:

vendor data: {0x3a726f7461636f4c,0x30434d305020,0x27000003fd}

This seems convenient since, AFAIK, MCA registers on x86-64
are of 8 bytes.

If we use sizeof(u8) (which equates to 1) above, then u8
pointer will be used for traversing the dynamic array and each
byte within the registers will be logged individually.
Something like below.

vendor data: {0x4c,0x6f,0x63,0x61,0x74,0x6f,0x72,0x3a,0x20,0x50,0x30,0x4d,0x43,0x30,0x0,0x0,0xfd,0x3,0x0,0x0,0x27,0x0,0x0,0x0}

Combined with endianness of the processor, this seems somewhat
inconvenient to decipher. Would you agree?

> [...]

-- 
Thanks,
Avadhut Naik

