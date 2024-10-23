Return-Path: <linux-edac+bounces-2195-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF19ABF2C
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 08:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE114285703
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 06:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782DA1465BD;
	Wed, 23 Oct 2024 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fu/zstvq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535539ACC;
	Wed, 23 Oct 2024 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666077; cv=fail; b=e7dcAVH/zesPT+4Mbku6sTvJ8PDKXxIA2XAR64V0pP2QObTGQIXzEVPGUTlIK+NrqtHlFuqekdZ8mRCc+EcbY1o0aSDcmK4p35sJTECn+0F7S66jcVgV5EJ1+tsRFI3IBzKrpa7z2KESbtxraJuu6AORJMoV41sYsMsbjTXUsG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666077; c=relaxed/simple;
	bh=NyTxBopQxFwBrcMKVQ8ODuNbsxLjWrzamIq7GNmWRuM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jQg/XFAm9z0QkGIB6clbGDMcPiZ3Mo2JiO2vzbxQieAjlYtpnVYlpSpbUmoV03H9lD8e9yrwNvuTPUpay5DzK9kL4+YdXqMy/yDIVaM7wFSL97Z5+cLlWnZpzq1uUo2DbeKhCjql2wgKVazk16ZGjTlIsU6se0JUHLiYltDFeVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fu/zstvq; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729666076; x=1761202076;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NyTxBopQxFwBrcMKVQ8ODuNbsxLjWrzamIq7GNmWRuM=;
  b=Fu/zstvq/LzC5fwZzRl29x8O1mzTFBJlDF6v+NZ6CRVjYsf/9L0TJjhX
   wS8h+WHPxCFnWytWrnFPWAqMvZU8k7pfTSiGtsQgEfp8IjEM5w8Iuzt0M
   t9Laqx0TGY5EPveZrbJXBq4qsDr+qEjABQLpfcQvCaEJfgi8Pkfwt1c2r
   CPc7w8Hf/AMObF5beIERbXfxADNuGy5zlEq18wcP12xGHVc77Urzr+hxS
   L0MV/drjY40iBHXW70fJZ+WvKGa0Y3JzJP+F8nJbk9Dn+oZi63i4ksXlF
   2bDzYtLVXA32+boX0BvKG7YYy508GaHu5iSVX43Jl+cQYE1N4Dusr9RxM
   g==;
X-CSE-ConnectionGUID: X/35jlp1SfyoEq2hNYqi+w==
X-CSE-MsgGUID: WSIWK10GQKKUwelSPGvxJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="33157406"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="33157406"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 23:47:55 -0700
X-CSE-ConnectionGUID: 1Hmgt1twRYW8myv0zvKSMg==
X-CSE-MsgGUID: EMWqiJ7vQEOx8L6bHep1Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84078073"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 23:47:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 23:47:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 23:47:54 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 23:47:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAIVR3i8HDc5BLLWRfr74dj7Yg0IXvVzxDcwZxyonPQ+3QZsQZEWDWHAraDOdwEXgAA5CbpXC2LDkOgsocSWBunqKLHUV5vPvvY4XpIsiZmuIhGTC2W+ABPY+hdvErJTUzthWGMJJPe536XafGNMrytLe5w6F9p5zYqNbp3ZlzCQkcYE1XMgiJvThJVT0NJ3ZXrGbKBe1o6RhX0OxVxE7ud1Fhxd3S/0TvU1P1qakGdKsAhI/cRu6MrhBCjDS48bP69SHCpFxyV8eKz0lQhJXKBnPSdei5E1soe2BzfkB0elrxaP2DywtInU7/ue1Cv3Ej2f9qCubdc62SpA+dO9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZoRCuRMQ/8go93X9BkvwzOVsOYYc3hZnZMyOSDaPaU=;
 b=tzDLIwVpjCF3s6Rcp3fAR2fG6mp22ThHY8f9tdpXX/aJDe0LTfhuFqVQTUUqd98+9lQhnzCHvI6MgAK7bMDXs4hvIlDK3qDyvBRZMvqNaFriiV6sSQGo7ftueY+WP2RyaX7wu8eg5w1CZhAeuxW8V9o9LYuvPtPhk5OTaQh0zIljYGCOZ8njFuQYJ3MsZ410u0EtDaZ5PEYiFMTxob2GNLkv3pZGS9xLOW4Tnn9odFDn/e7ZIkGnesxfrnNno5S+OzVuRuF9sUpsFRi6MiDFSLFs8zx44QiqquKgN4bm+D1CZ6HFZ5zPGRs8mYvFwJvYEhMaeu55Edos3tyRTvf/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS7PR11MB7906.namprd11.prod.outlook.com (2603:10b6:8:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 06:47:45 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Wed, 23 Oct 2024
 06:47:44 +0000
Message-ID: <c3bb0055-49c5-4e0f-a9bb-8f56e862e11c@intel.com>
Date: Tue, 22 Oct 2024 23:47:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Luck, Tony" <tony.luck@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::22) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS7PR11MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: b324850c-299c-41cb-2ec0-08dcf32e990b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1hHWklYTU9zOFVJTHNndXVkdDgyN2xjeDU5UFFzb00rZGZRZ0Z4djRIZk93?=
 =?utf-8?B?alNyaFBTUnFncTZ6bDl6YUZiN1N2S01HbUtKOFFYdVY0VGRPVDN5dWp3d1Uw?=
 =?utf-8?B?RUdBcVRiOFAwTlZTa0ptL0tHV1BjTnZmaHB0RGFMTE1FV1dDdkpXVDB1bmQw?=
 =?utf-8?B?OVRyWVpEODloV1lWTnA3RnVKWjRKaVVMU0I3VUphN0ZmNVJsT2lVRWg5aVZX?=
 =?utf-8?B?ZHAraXBWNFNLZkhOMnE5YS9ZUkZnWXZaci9lWldVZnlTT0hMS2N5dktiNEth?=
 =?utf-8?B?cUdTK3F1WmE5QWRPMWV1ZmEzUXpPMm03TktVVGpneWk5U1FDNlk2Z1NhdWhF?=
 =?utf-8?B?NTc4T2dGUDdmYUErdHZTRG1qSTloNlk1Zit3QnhTVitPYW9EeDQ0QmV4dUNh?=
 =?utf-8?B?RWlTRWVHdUgybm9WZ3h6N2RoQWRmd2haTlRSb2RiSkxaRUNqL2dyN2xsSFVl?=
 =?utf-8?B?b3hUWllQaGQ2U3Z3TDhEUUNwZkJRQTczbS9zRGQrNjNnUHgzM3VLZnBLeDli?=
 =?utf-8?B?RHNzcGpEa0ZKZFk0aUJrQ1FaMGw4MlhTZEVRWnZXTVVFSjE2L1BwTG8xYnRr?=
 =?utf-8?B?aXdnK2Jod1M3M2ZmYkxXZy9QVmZLbkdXbkJHVjc5MTV1QjFvc2xZeWMrRGNP?=
 =?utf-8?B?ZThTeXI0aU9GYldCcVl0UXV1TXl0c2l6NGpINDdsYUR3dFgrcU14cmk4ZjVF?=
 =?utf-8?B?SktVTXVkL3Rva0lETWNDUlplSFAvdHhJMkp2c0hEeXU0eEwrMjZETnFqTUt4?=
 =?utf-8?B?a3JSNklrdVpMVGxvSWJJMzZOUGpNb29kRVF2V1V1VFcrY21DTjNOVEV1aUM4?=
 =?utf-8?B?N3JoVHdQbjEvWWs2ZElob1JybVkzanBOL1FiMERYeDErSHpKNkJOMVA4TXlW?=
 =?utf-8?B?Ny9rVkNoZFpxeEZHM3FvRUdLcmE2VTkwMS96dmhMZ054NU04di9TTUhUOWhC?=
 =?utf-8?B?ZmR4ZHhWb0xXM0p1TlVrVXdPczUrbXJVM0tMYzZ5OGV4KzFFMkdrZTNPdk15?=
 =?utf-8?B?QUJweDBjK3Z3ZzhITkNNWEJuNXVjMlo5OHlINXZ2am5nWndKeE5PcFVVeUNG?=
 =?utf-8?B?OTVoQTMvUXdPckhyYkptRzRVd2o0anFhYms0cEowcDc1THJKdStxWjV6NXJC?=
 =?utf-8?B?cDhDbGR5K0hNZHhIbU1YdzVzWXZHdU9QM1NFNC8ycDExNmRnRWY0UUR5QWJh?=
 =?utf-8?B?YjBvN1hjTENqUUpZTksxVzJ3RmJkajE3a0MzMkY0eGlXbkF0SUFzeDNXTVpn?=
 =?utf-8?B?SWVqODhMNG5RK1cvQk9Xd2kzY1dGZWl5d3ZrbVltZ3l5T1ozTkhSNUFaOHdX?=
 =?utf-8?B?TmtzSUYzVVNTUDB1OTBjNm5pQWsrcnNSbjNpbVZ2SUQ4d0dYUjBVWUE4dk8x?=
 =?utf-8?B?dWJ3TGRzMTRuNjBwUXIvdWM0YXB0cEZMekRNSU0vVEk4emJLY2xHdjdrNkZ3?=
 =?utf-8?B?TStVek1oMThhZk1WZHNjYmxOVmRYcU5JbHdnZXY2TmFlNjhZSGlJcVlPYmdI?=
 =?utf-8?B?M0dyVmNJSnlXeStMc2UrcTE3dXVNeCtZWEFteVpoMW9rNTBuaVpBZVZoY2to?=
 =?utf-8?B?WFNZZ1k5MERRdlkyR1lBUXhJelZjNFF3c1M5Q2NLaGtyTHZkM05sWHBUdWtZ?=
 =?utf-8?B?TEJ5SDFNeXJMdExJeXp4aVBheHZHNzZRQUMwY3Rtb3NSR2dMeXlBaVZqWjNa?=
 =?utf-8?B?Q01jSFVSU3Q3VUQyQU5lNWUwSWRrN3lyeVJlZ0pLbm9qelp2azc1Y2dmUk9x?=
 =?utf-8?Q?27N2D7lIgXhnnoU/4viqd+a2v8/RTs+ZPfoTnGR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjFsN2s3cGxkMldKYjV0OWd0dFZNR3V5Ujl4TWU0SnBiaXV4MDljdnZ3cHFI?=
 =?utf-8?B?ZXIvdnFLdlhXK3FUYk5haW5EakdsOWVpQ2N4WG9OalFOZUtXL1NOeG1HWkJO?=
 =?utf-8?B?QmNMRG5aMGVhdEV3dmp6NWkySWZCZ2xxbEN1UkRaSVFtTFJqL254ODRHYlEy?=
 =?utf-8?B?WGV6MURyNG4rZ1Zmc2hqaXRhRDJ6Qm5OUnMyNktaNUpFWWZJZkdPUndoK3lt?=
 =?utf-8?B?eUtxVjhSaFNodDlrZWFrQ1U0ZHBZU2pvam1YRVBiWjl4dGlhYklOMlZSVkhR?=
 =?utf-8?B?eVZ3TVkvYlVNMTJhNm5HekRaWloxT3VQNFZ5a1BneWlBT3FjVjZ0c2c4dnpa?=
 =?utf-8?B?TkMxclhGb2tQZjFNdGJONjI2YnkxazdnWktHdG1aSTNBVnA2blFheVcra0Iz?=
 =?utf-8?B?S0dpUEdCUHJ0SExqMEZ4Y0NUeDU4TmI1dkd2UEoxUWpHWXRhdDFnQnA1Ui9U?=
 =?utf-8?B?Q3haSjR6NkxKZ1dvcGhhaFd1MXNabUU2S2JNUFN2R2pMM0pQRGFOcElOc2Ex?=
 =?utf-8?B?Nm1tME5SMmRYZnVDZFFuWkNvbDZEN3NGcHlqRGRsS3BFaWpMeGtES0xkaW53?=
 =?utf-8?B?NW1nQ2FhcWhRMjR2MnFGbk5kaHRHQjB0dk1vd2cxNVhVRWJHNTRjNWRBOVVV?=
 =?utf-8?B?aHlmTklHa1U4Tm5kTWNrMGNZR0xLVnBwNTRndjkwMlcxY0RQNkJrSk0wakt0?=
 =?utf-8?B?WFFpL0RLR3NSaVBqTTlwWmR1UGU1M2pKaTBGUVY4SFZVZkQyaUlPbWNiazdL?=
 =?utf-8?B?eXdMODkyYWdNenpTV2prNkJmbDhqSTlDdmpKcUdPcHhacVFJQWY3YnV5Rmw4?=
 =?utf-8?B?dDhiMTJHUDQ1UWdrcEsxdXlFNldLcG05TTdtYlArNmkwMC9SL0FTOHJJTHhS?=
 =?utf-8?B?KzZDQmtqS2xYMU16b1djWXp0ZkFaWERydGdiclpSNjRHNC82NC9aUGxrYjND?=
 =?utf-8?B?a0s5cFBpVnJkRFltVXFwdWdFQ3VIV1oySHJzNVRWanB6WjRFODZtVFpCTE9k?=
 =?utf-8?B?cWJ5T2lua0R5OGk2RTJTdDRFZ2c5V0U4cVN1Z0QxcUFnSEkyODQxTXZFcm9P?=
 =?utf-8?B?YU9WT1o0ZWRTOFNXTFpEMzVKdTVLczJHTFFoc09Fb1k2Y05LS0d2Y3RKR2hm?=
 =?utf-8?B?NWwyMDJER2Q1NXk5ODNUTGpoMkVzRncwNUFJM2I1YnlESXhRUzA4OTFTTGpQ?=
 =?utf-8?B?a0pxV0JzcENQZmQwTzgwbVVFZVl6VFAvRkhva0lyRGJYTUdCZHpTWVhzcEtm?=
 =?utf-8?B?bUROakpIM3d1OEdmZmcvTkhLRVhBd0llc2pSaUo3NlRUWXBlRU1XWllIcTBE?=
 =?utf-8?B?NzdBNHdiWXhaaU8zWjZncEpQTW9FUDloYUd5dHNWNVgzYm1iaDFmRlRWNnJ3?=
 =?utf-8?B?T0tzM2ZzK1pWU3B6S3NZdTM0RWJtMWFYR0dqVVJUNVd4azFRNW1NNW95SWFy?=
 =?utf-8?B?Y3ZreTVFOWxEeXdTNjNWZER1K29JeFpIcTV2VlM5OHBKV3hqTWVOZVU1YnQy?=
 =?utf-8?B?bHhudThlbTdsWnhuOFowbS8vbng0b2dYbnI5VGdEZ0E5emxTNWlYaGJ5dUxB?=
 =?utf-8?B?R0VKL0dKN3NCSmJXTXJqTlpCRlVycGNDcHhENlU4ejZaUlQ0WEJJd20zWXg3?=
 =?utf-8?B?VUVFUUZMNHJjQkxUL3h5SXVTQTBKWGR3dDk4dHhoYWkvOWNNa2pZSmVhajBZ?=
 =?utf-8?B?bnFqMGRWcVpWR1NmTHlGOFZ2eXRFU0EzRlFZTkthOHp5NWJWOEg3NUwya2E3?=
 =?utf-8?B?dm13RmdhL0VZOTJZQ0hwME5RbTl2UnNvc3FuTk01dDN4L1BUYldBSlpwQzhO?=
 =?utf-8?B?eUgxQjAwd0NHOWY1SXcwVVlJTlZBU2hqdmFpZkhieHlIYURJakVPTWNkbkZp?=
 =?utf-8?B?MG1WM3J3WldyNXdRUVRmOU5KMzJUKzU3enJQaE1hOURRb3JaZWp3MnJMTGly?=
 =?utf-8?B?WHFaMFBVZ2tpbFZKenBqWW1vSTdpMENnY2JpczAvT3FLWUhPRTdVSisvOG53?=
 =?utf-8?B?dXUyK1duWkJUbmNRVEVzSDFGVnlnaHBjOER1cWRMNDJQRVNrSWw2ck8yWXdv?=
 =?utf-8?B?bTlPSmNhL2J1SnUrVUZ5OEMrTVpaTkhFTVpGcXZSa0FWRDAvTmYvNHllR1pH?=
 =?utf-8?Q?Nst1jH8WIufP5hPnyec708z0z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b324850c-299c-41cb-2ec0-08dcf32e990b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 06:47:44.4649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHQYwgXUc82/IiOhYAJBGEWKIrvqg/85MzSRlz6j0Hrj66kAAKxmnUMFhky4/35sRqcfQbmLfaGDWzUxKPcgCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7906
X-OriginatorOrg: intel.com

On 10/18/2024 10:46 PM, Zhuo, Qiuxu wrote:
> Convert some hard-coded numbers to VFM macros on top of Tony's patch as shown below. 
> Please review it for any errors or omissions.
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index f51fb393d369..3b83efa1ca65 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1924,6 +1924,10 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
>         struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
>         struct mca_config *cfg = &mca_cfg;
> 
> +       /* Older CPUs don't need quirks. */
> +       if (c->x86 < 6)
> +               return;
> +

As Dave mentioned, change this to make the use of vfm consistent in the
entire function and probably update the comment as well to make it explicit:

	/* Older CPUs (prior to family 6) don't need quirks */
	if (c->x86_vfm < INTEL_PENTIUM_PRO)
		return;


>         /*
>          * SDM documents that on family 6 bank 0 should not be written
>          * because it aliases to another special BIOS controlled
> @@ -1932,23 +1936,21 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
>          * Don't ignore bank 0 completely because there could be a
>          * valid event later, merely don't write CTL0.
>          */
> -
> -       if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
> +       if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks) > 0)
>                 mce_banks[0].init = false;
> 
>         /*
>          * All newer Intel systems support MCE broadcasting. Enable
>          * synchronization with a one second timeout.
>          */
> -       if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
> -           cfg->monarch_timeout < 0)
> +       if (c->x86_vfm >= INTEL_CORE_YONAH && cfg->monarch_timeout < 0)
>                 cfg->monarch_timeout = USEC_PER_SEC;
> 

Instead of keeping this open-ended we could tweak this a bit as follows:

if (!(c->x86_vfm < INTEL_CORE_YONAH)) && cfg->monarch_timeout < 0)
	cfg->monarch_timeout = USEC_PER_SEC;

Essentially the same: if (new_cpu) vs if (!old_cpu)
Don't have a strong preference. Will leave it to you and Tony.

>         /*
>          * There are also broken BIOSes on some Pentium M and
>          * earlier systems:
>          */
> -       if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
> +       if (c->x86_vfm < INTEL_CORE_YONAH && cfg->bootlog < 0)
>                 cfg->bootlog = 0;
> 
>         if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
> 

All the other checks look fine to me.


