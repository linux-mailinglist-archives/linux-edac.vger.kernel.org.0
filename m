Return-Path: <linux-edac+bounces-4332-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0E5AFBBE1
	for <lists+linux-edac@lfdr.de>; Mon,  7 Jul 2025 21:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BA71AA7665
	for <lists+linux-edac@lfdr.de>; Mon,  7 Jul 2025 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FE3267386;
	Mon,  7 Jul 2025 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JVbVEp/D"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556A266EFC
	for <linux-edac@vger.kernel.org>; Mon,  7 Jul 2025 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751917704; cv=fail; b=lGpz1DEAfeeE5OH3OBSd9lowCjBBrOPK7aaCqrNaxfuKSbsHPi2JlWGNQL9NedjTsO3bZjrwOZVe2KZ7x5gvtbUSCOB6978kXVB7MRELEMh5kKNHSbSEDuQ/ohQEvFv0tnJ5urmUZ0SOEZIH8RV/TNCjzpNImxbgVS69Aow7d4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751917704; c=relaxed/simple;
	bh=tlikFlSuigZmdzPpgc1+RA+BcTefTGJzydxzmmAZP48=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NvzCTcinRZphbY9sHUaNHSW6uSZTPQkQj/QKYQc/jMW9WiznuAZhzL7V2uH1JoD74j+lYCrePwGKJi5Z0vICpu9I1vMu+0dTTUNZSvSO4yYAfiHEwvzsT5FFPsE2r4F455uPWw5FUfml3DLfb3za9g9KYjdKZMKqx0Da3eJQbpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JVbVEp/D; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVcg3u2K3xA3SYN6ukW/J4WJwQXXUfdwfMtgHFZFSSNpyOLaIDm1K/0vShncjS9C/cP7COuN6uoDMWIuOSxBrKys50pQKSU0hzwQhU4/q5u5uQ8Bm0T1F5NkA5qZQbpmCLCqk1atgcX53CeAhTAxegk1PO9xPgQig853eGwqiW/kTZjVwvqrOQCmZeqFbHKZY7P7mRUOlMRDriIABblu6HSy4K7eeW5eb+SCJOx1JBOXWdi5TlTRRopLJZSec5/YtTR2jyzGhZ3GvR2nmuWzmVklirRPfA5UrjHv91WmUF7uvIrnSvQ/qkIEnDbDrbwL+FXL0kPVqQDaPlfsjn5Jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AIoWgIINkri9KbJFO5MStK4iDLPpxSv7PL3T9Vp1nY=;
 b=dCwyjHeO+xcUM7Hs3Xurwho2AfPilrf/4bYwlF48erabOyfyVIESNdlsR5F3USAiJOl0/A5XC2hEzhz/1OAOafycRb6lKw0Vg3u3XEhtSiDC3tW2U3fcBm1QqRcVtBBRflcV+4EgSE4hFCePjDGOymWy2Klk5nh8l7b1Sdcf/1IBIRsVowYFcZ8+jOAoKXfSc24MjJaTRGNjqNa9cjlJ6dg851rl9t4i7RgqU/EhjggdeH3kkxEnLNjOhbwGpOY9UFSIR4aIA8QaoKACEBTBOO6vdoTx0iIu+Lh/hMekOlW7kBYSFiPtzjqTF2IiV3+ITbGyrWxwWjaMed7Z64id3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AIoWgIINkri9KbJFO5MStK4iDLPpxSv7PL3T9Vp1nY=;
 b=JVbVEp/Dg5IE3cSDQVIry/TtdiOaADuxiPJeCev5728ErFRLqxTz0QPBvsqtsOQKWK3pkC8RzKr8uWh6GA9wqm1J0Ijwz1+TQyKVtT8LsFyZ9wG6rWFMluyo/CKqvSEff2s5OR+bVDspeAUSWC2QbkvK4yUrtXWN775EWw6vaJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 19:48:17 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 19:48:17 +0000
Message-ID: <f2a3f42b-606d-456e-9ea4-ae50cf951d41@amd.com>
Date: Mon, 7 Jul 2025 14:48:14 -0500
User-Agent: Mozilla Thunderbird
Subject: amd64_edac fails to detect DIMM with only one ECC UDIMM installed
 (works with two)
To: James Blake <jamesedblake@protonmail.ch>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 "tony.luck@intel.com" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <WWtcG6KurPUuwF9vO6BrD2SXUmU20OYqRPPpbGD9Oxp9ZmB8KvHdFELQ9zURHvcXiF5WE2UdhZwbGlvxVQV82Srwl7B9bMKvxFhBQyPTET0=@protonmail.ch>
 <20250528164459.GDaDc9i5ngUZlWECaU@fat_crate.local>
 <c1a5dbb5-3498-4ac3-a278-dfde3f005e6e@amd.com>
 <20250528175819.GGaDdOuwb-nzE6FfYs@fat_crate.local>
 <Y2t3NVJDekt0_ZKiu49pm_CcUtPa_2P5J7nfX2pDyU6d86s654OzT0-HkAe70ADRKjkQWPTVEeRxe_D1LKBfGWi2bm4rRkN6r4oxN62GMn8=@protonmail.ch>
 <ICqp-rWBvFH6C8JZr5ejYGojRAJBq4aDTIQxeZ4CpJJClm0ORSvW9QjbrefiVG3Sryws_xpBujUiznDwE0UQ5ETrued4QW9i09uxszKcp-I=@protonmail.ch>
 <7c2641be-5de0-4dca-9e19-d95338a4528b@amd.com>
 <aslwygWCw5z_nOMYqQhOKIA-Q5ULLr8kyjFw2l2N5w2A335UbSHKWfdlwBC0eejJCy7Lan5Hzp-4rOirHr0qhL37XFVo5Y5ZAS0wfeZZCLA=@protonmail.ch>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <aslwygWCw5z_nOMYqQhOKIA-Q5ULLr8kyjFw2l2N5w2A335UbSHKWfdlwBC0eejJCy7Lan5Hzp-4rOirHr0qhL37XFVo5Y5ZAS0wfeZZCLA=@protonmail.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:806:120::27) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d3c2f9-ff4c-42df-57e6-08ddbd8f373f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWRhSTREVE5EL29rVmtUdWNDWmNuakN2bTlJSG9DTGhpSlBVNjdyS21nY29Y?=
 =?utf-8?B?UnpPd0dJNG1GSnhQWWp0V3NjY0NBM1lmR2NoVDFmd2JJMW9vV3owaDlTK0py?=
 =?utf-8?B?NUxuSVpoM2JsUlRuRXdFR2lBeTIwZnNiZEttOUpBaUhrT1lPM3hreVl5em0r?=
 =?utf-8?B?ZVIzcGRXTytZQ3pteUlHSlJ4ZzY2elJNTmdjamZrbEF3V2VNdnh0VzRzSXR5?=
 =?utf-8?B?cEhhR0J3OUxVQVFJUzNjTjVUeXppTVFnaVY0RjZ1THFIZ3ZBdU9ETU5NVFNC?=
 =?utf-8?B?bTJxaFl5NE41UUVkck11anBZYUQwQ2FybzJsa0k3ZktKNjNwL3hPSTRkd3dK?=
 =?utf-8?B?TkI1bmxkNm5yVzhaaThTTDVKUzhsa2xNWGlVbDVxT3g1amFHbENpVGdweVFG?=
 =?utf-8?B?V0VKczRwYXdDNUt1TXJhM28rYXNKV0svYjFHcHY1M2lwWk5jNFlLckVUaDdZ?=
 =?utf-8?B?RkJQM3Z1cXNQV2NSN0NSc2N6R0hLbmpwRnhwTjV4UVJzZXFmTjlGVVhFSUNt?=
 =?utf-8?B?ckFXS1EveDBORy9sUjFtQlp0WmlsakVHb3k2V2llMHhpQTRyMkpta0hQSW1h?=
 =?utf-8?B?bUdRTjFoejJLYXhtbmRKMXRuRjFhRnZvVVU1SWxHR2UwVUFSbHJwa3RjVklw?=
 =?utf-8?B?cGtaMS9WR3ltNWF6R2JUM3N1ZUpoUHBLOEZ1WEJ5dHNmaGkvNjQvZHVXUVpi?=
 =?utf-8?B?MEVPTExuRDZ4VXEvRklDMUtDQUN1c25GaWV2TGtxVWJ5Ry9OWEViWTJNK0po?=
 =?utf-8?B?cmpXWGNnaXN5ZzFsWit2KzBlQ043SHRGL0NvZU5wcFhNZ0VYTXR6V0FzaXdD?=
 =?utf-8?B?U2thRVFMNzlEWUhQbFd6WFJjdnphYW03S1FTU3lUY3hOZXE2YysvNmJoQ01h?=
 =?utf-8?B?UDdaS25XQmR1NTZDa3dJSDNWemFpMjkvbTRLQktiRXN3WmNmb0lkd29TcEJu?=
 =?utf-8?B?S3lKbTlydzhPaWU3VzBMZk9adlEwMENpczBhWGxoZXFaNEgzVXl5YmYxUytv?=
 =?utf-8?B?QXZhTWgzUWZjTmVnVjdpaW1LT2JoeTVBUzVSd1I3QmRnWEN1dk1zUzdVdzFS?=
 =?utf-8?B?UUY0OE1QM2YrakE0dUZZVlR2RERaRHJ6bHpYNEdoNWNuZXBqSnRnV2VJelRr?=
 =?utf-8?B?MVRXa3V6bUFxQnUvUHNzaE9XTWJJV01BVTFNMjJKMURDS3VOa29mNHFPUFNh?=
 =?utf-8?B?UWZaM0FZbk90OE9BczBGUDNRclExeko1VEN5SlNVUEMzK3pCTE9nQUJjVUhO?=
 =?utf-8?B?eVdVdW1DR3h4OWZlMy9SRWFGTGpNV3NRbmFLa2JTVHM4QkFaeVl0R09ZVGl0?=
 =?utf-8?B?YkdRN2NMd09TZ3dIbDZPMkVTam5KaGVJMGdIOWFOM1d4NVZOVW1ocG9udXlU?=
 =?utf-8?B?ekNHOXMzdEQwRWdYdHFoQ3daUzhEYUE0OHZ2dWFqeVI2WTZycDhuL0JOTy9N?=
 =?utf-8?B?aXYwQTFYUHVoQmxJY296Ykw1aW1qeGNKSHVweFpvdzNRb1pvYlZDZ2Z6R2Rn?=
 =?utf-8?B?ODd3RGpnUThQSzEybldJRlB6aldnZTBucUR5ZFcrdGRzajY0ckF1Zm45bU5C?=
 =?utf-8?B?eXNxMUhxUC92K0FwVTRTb0RleWlTOTh1b1MwWWdGdHJaM3FZUzViWTl5S0Z4?=
 =?utf-8?B?RmNRWVB3VFUrcWdQUFIvUlNHVHB2OW9tVUhhU2FBQUF5VWpFUkxNVUFTaFBx?=
 =?utf-8?B?M25GRU1sQThVVVNkMkRLMkx2Q09zbVVQS3JMRkNWcm9kcW1heDdNYWovc0Rl?=
 =?utf-8?B?NkU0eHYxNmFrSU8xaE5RelRlaGEvYXJaVGJsYkFPVnpmWUkyV2RsbFhNdnJF?=
 =?utf-8?B?T1VrT2xpK29kSTQvU2VOSi9qdXoyTVV3cWZBUWxEQmZLMElJcFZkVTlKYVNO?=
 =?utf-8?B?NmdMLzI1WEY1b28yTnZNRlZ4c0pPd05DaUx4UkpzYklmMS96ZWd4eVR1a2Zh?=
 =?utf-8?Q?uOQtAKtdaJA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXVPN2N1NkRsN3NpWjl6eE5JQ25pV2tEcVQvZFI2dTBIZTh4cWpWaCt3OU4w?=
 =?utf-8?B?Uk9mVUhUYm9MaitGeS8vWUxyaDNBQzl2QUpnZEp2QmRKMmlXWGU4OEZ5K2p6?=
 =?utf-8?B?ZnlZbmlPVFcwR1BERkxzUVd1L3A2R0M4WkxrbFJPbmNwUENtaUFRd1I1MEw0?=
 =?utf-8?B?UHJ1MnpEbStOT3dWbjRNNTFvQ0NjNjRVT1lVblFOYjVXckJQRjdzUW1IaVYx?=
 =?utf-8?B?WGJIKzEwcW01ZHV5aXdzRVpwVGgreHIyOVhlMmFDWmdIOHJqMnZ1eEFJbk5P?=
 =?utf-8?B?YWtybThkei9aR1hNSHFBWCtOWFd3aWpDL0FaM2liVVA0REs0bjZBRXlPbWNC?=
 =?utf-8?B?ZEEwZWk2M3IwTXZWTVlwNmt4RGFQTENCeUlKc0VONmF4QStxb0lHcEpYZXIr?=
 =?utf-8?B?aDh2TVBxOG9nRi9kK1VxQktUVEdyVXhEc2U2T0t3dnJ2R3hrcDJpNlRyVkZ0?=
 =?utf-8?B?MTJWSUk5NEpqclc3NnMvNk5vWFhjam55bXFqeDNNNDdWVWFnOE51Ukd1V1pS?=
 =?utf-8?B?RVl2bThROXVuaDZrS2R0dm1EcWtkVFRhbXRxYmJWRi8walNndVk0Y0VPU1FF?=
 =?utf-8?B?RTBCbWluSnhLWklIemZtekRQZUx2d2RtckFObGViclllWUtKdFFVc3BLLzZN?=
 =?utf-8?B?NVdBaHhWd3JpSzBxbkU2a3g5eklBU2VOM3FDUW56Q3lnLzF2TGQ3SmRIVElO?=
 =?utf-8?B?NjNsQWp4RW9IL0I1amp0K1kzZmVmREJ6dmpqQmpiSjNORWRZWGwxT3ZpQVB6?=
 =?utf-8?B?QU0rd0VjR0Y3ZFlVT2tYOE1aQlVoamNrd1I0SlJ5eUJqd3ZLcGlEYU1uSjY3?=
 =?utf-8?B?ZldnUzZ3ZzlTQUlhM1lqSDF1WHZXMWp3OXVEVGY4d202UzJtOXVwYmtUTDZJ?=
 =?utf-8?B?V0dLNThSbnJqa056ZjZ5UnJzam52L2lPcEFOZkYzL0NFRnJBK1JkYnFNekZU?=
 =?utf-8?B?VFJ3QitOUmRzdStVcFZhSlExSHNCUTR3QkxseU9xc0xQWWVYM1ltTnlkQU5n?=
 =?utf-8?B?Wi8wSlQ3RkVTT2FJY090d1A0aU52aDNEb0VxSHJNMDhEWjY3N1NsTkhIcjk5?=
 =?utf-8?B?MWN6V1FyT1YrdTJxRWI3aDN4QVRWUld6NkRYVmZ4SVo0RUJYVllqQ2c5SGxQ?=
 =?utf-8?B?QWt5SUtabE0vQllObVF0SVhrbFFLbDRWVi9rZXQxZ2xlcTljclBDOVZuOFNi?=
 =?utf-8?B?RHRxNGJueG1VclRuZ3QwbWRxdGY2a0FhSEVpQmxnL1BKbkxiSlIrOVEyZnNy?=
 =?utf-8?B?UFJIYWpnN3piQUtYb3p0NDJONk5ZejJQZ2N2Sk5ZUklDZW05SGZVWGJHUjZ4?=
 =?utf-8?B?NmxkVVk1eTZrQm5HdnhDblRTaVQxU3RxQmwwVUlyREdaMUJxYVB0QVlDV1Bh?=
 =?utf-8?B?aEFheW16Sk9IVXN5YXZWR1BxSWR0dTRnVFozSEYvR2VrVCt0VnpMY1NUT2o4?=
 =?utf-8?B?QVA4VjhYYkI4SXpqWGR3QzkzL29BSDVKVndGSDRNajdDOFNZa2ZwN0dINFVF?=
 =?utf-8?B?RVBIMUc0NElYZmkrdm8wWjFScFI0THhKUUF6clViNm5sM0UyOERXYVlDNk53?=
 =?utf-8?B?d01naEhXbm1hbnRHSEREQWJHcngvTVl6LzNMYktPSGNFSDJDWXlPTDJ2bURa?=
 =?utf-8?B?Z0EvcTNhOUo5RXAxK0RQc1ZnQld5WWF4ZDM0QitUb0drTGg5end4TW5yWFBj?=
 =?utf-8?B?VFhaeDRFZDA5dndJZ3N5RTBINVZRd1NoVktzNDRzbldYN0Z3WWFscE95NE9p?=
 =?utf-8?B?bjJkRms4bVZwWWcvREdhcW9ZYVpGd29mK0o3dVhZMmJGMVBNblhQLzdFaXNN?=
 =?utf-8?B?OThQS0pQdkUreWY4a0lQL0hEaW5hS3hncjNCai9pRmdVRWxDU3lzbjNZSDg3?=
 =?utf-8?B?ME10VklBdk96eFZCNmsrcjVmOWszeFcrR1orMUdFMUd5V0hZTHJkVGQwZDZQ?=
 =?utf-8?B?TktYUG5aNVVCbkdtRXZvOUs1bFBsNjVQbVJ2QU9BYk80ZVhwL25UMjcxZkwz?=
 =?utf-8?B?VUZ2RnJoSkptZVhSNlBMM2RvNWgzR2FhSk1lRGRGTUdjRW1ieE5xMXQ1UmJ5?=
 =?utf-8?B?TE42U2F6Ync0MlBlSmgvSm1SQjJDODFrOGRVeXlvcC9rM2dyTmcxYjVwUkt6?=
 =?utf-8?Q?f8Fl+ZbosGDMOJwLsNrPXF7kv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d3c2f9-ff4c-42df-57e6-08ddbd8f373f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:48:17.3897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TX5Jnj7pe5/6praqnSHrTbd5hm4DxOR1jiIkGnMvbAodbeSKjoEfueDiWbUxSEUjBoU/Obgkmr2m+N5jvagEdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383



On 7/3/2025 09:33, James Blake wrote:
> I also apologize for the delayed response, I completely missed your
> last message. The patch you linked has been added into stable if I'm
> not mistaken and I tested it right now on 6.15.4. EDAC's output in
> dmesg has now changed to this:
> 
>     EDAC MC: UMC0 chip selects:
>     EDAC amd64: MC: 0:     0MB 1:     0MB
>     EDAC amd64: MC: 2:  8192MB 3:  8192MB
>     EDAC MC: UMC1 chip selects:
>     EDAC amd64: MC: 0:     0MB 1:     0MB
>     EDAC amd64: MC: 2:  8192MB 3:  8192MB
>     EDAC MC: UMC2 chip selects:
>     EDAC amd64: MC: 0:     0MB 1:     0MB
>     EDAC amd64: MC: 2:  8192MB 3:  8192MB
>     EDAC MC: UMC3 chip selects:
>     EDAC amd64: MC: 0:     0MB 1:     0MB
>     EDAC amd64: MC: 2:  8192MB 3:  8192MB
> 
> If I understood this correctly, it's now reporting 4 dual rank DIMMs
> with 16GB per DIMM (8GB per rank) instead of 32GB. It's also reporting
> 4 channels while the motherboard has dual channel memory, not quad
> channel. Am I correct?
> 

AFAIK, each DIMM slot supports two independent subchannels.

Now, the system has 4 UMCs, each of which supports one of
these subchannels.

Thus, the two DIMMs (4 subchannels) are supported by 4 UMCs.

HTH.

> Thanks,
> James

-- 
Thanks,
Avadhut Naik


