Return-Path: <linux-edac+bounces-2141-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AF19A46ED
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 21:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F001F238C1
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ADD205AA3;
	Fri, 18 Oct 2024 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKk85fSk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B4204F84;
	Fri, 18 Oct 2024 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729279225; cv=fail; b=O12f3Icwq55w7U3uotpI327IiNXiIYQTb2Duh1Yixcv3y+LMIlQemMGBaWy6l+2JHzTPWXYjOrtgmyLzpTLx8/yIKqNVHBxOY9bmqwipvM889agKKg3K04sQk6mctDileqanOpcD+tu8wvx28J1y64xJ++RQ6SBsW8rRupRMLcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729279225; c=relaxed/simple;
	bh=d/OAJDjMLD/r/YdhM8ATrpiEWzFrB/fQuVVrjelt+X8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rOpDOz54veimKRlFAM2LVQNTwCdfWR7W1StKyEocgPvA+m6PtnokoJDaew13lIaXSGF1TwCNbDLg6oXRFu0X7TFbIIXOKVdhPWBFPqcQ6hF2qDG4a7xEx99FKf6ZQvNt+V08aN0Ja/1YvUKlkb0EUua3R+bWnwg715eX8+xmKrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKk85fSk; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729279224; x=1760815224;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d/OAJDjMLD/r/YdhM8ATrpiEWzFrB/fQuVVrjelt+X8=;
  b=jKk85fSktLd6kKhG5qt/1RrP3fVW4+KhhO06kkQUFQOD/pT/xT2n5p27
   MvH+eMngXZFhOhFdm7KE2XAE4TFbjNP0yiLJPvaZ5irbkR165xUs6fO6K
   c/JI/eUkTMcpMJUuf/xB4CII4aHVpLpkqNtjVbwole3IoSddYk+vZOtaG
   hmSFkZcf43IBP+s5BCSx0zM/XUwGq9cRB8ruRjG8vf+OWXoAsoOlzO1Rz
   xIA2xf4GYPIb+BFgbmg2WvDp7ULlDSLJDl2VW4QuGJZIkAplecTFGwPxk
   Lmyvkpt7sR4e0yjCLZFMA0w53aDNVhAcFiKw2+eXNmlmIbxD+gM3JXgNv
   g==;
X-CSE-ConnectionGUID: SoLMKoSFRgyXLjBfHFHrgQ==
X-CSE-MsgGUID: dc3aHQ95QmynsaPCMSHQ5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28616136"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28616136"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 12:20:24 -0700
X-CSE-ConnectionGUID: INxkQKlBQqijZfvLyM904w==
X-CSE-MsgGUID: SguxG+gASYuyq5KwzhFz8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83531555"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 12:20:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 12:20:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 12:20:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 12:20:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 12:20:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6A+57aC/8a7PYr6buTl6yd71NR114pxvebKJCQkerg42d87kj9KdolIbQE2v2ZNcO6GvMVwyqoaP1bvpyJr0k0DAb5r0B6dHUe60jk5q8PKLlVp9hDjaRdpRfBdXSUDuTp4RWwUXBant4StYn0UwT3WqZtBER2CtfICdcd/IMAdwW+1KvClMyUuswcZN97u3eDvLIUqJpqVAkge1XOPngpaNTqX5S8ooQX9GcTjtvH+2pUPcz/faqNd8rBsTQ8oRnYdn2d98Mu/4AnoPPGnUGGswH5db4covCoR3D8M5jqcjb9/vBeAs9wComX/ouH/Fviyp5RNubxG50x+BxnjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRwS0LoTeSX3HDzcawj5dEERZGL3RMhpGK3AAYrO21o=;
 b=dDTO2ci/fcP4n6hiJnShqfLpye5McDHxScLhGhgXEIBKjczKfFpq8WkMY7BuB/KhgsZ+aIovyuCjLOsA2UYjB6gXXb1urE21QiLeWzSfauolLu7DkEu2xtlJqGcv9Wr+WM36xg5sWAigHxMFUOVoollWmlnasz4rY9Hi4EJQEbisJa3KzuCU5Qgg+BXCwEiGWttNjbpD4Snm8FI0MYvILTvzRFKiXJI7Ohp8Gw6P1cFAW05ZzDpa4B769xb0Eb/Vmy6TFhe9o5ssRoUSl76cBxitwIAaG5Ghn6fF41jBlW9pdgGBbjz1Jz4eq9ltNILETA3SGj1Ic2hiI4K7PeNVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH0PR11MB4917.namprd11.prod.outlook.com (2603:10b6:510:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 19:20:18 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 19:20:18 +0000
Message-ID: <075d1720-2c2a-4be4-b5b1-45ef9c309096@intel.com>
Date: Fri, 18 Oct 2024 12:20:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] x86/mce/genpool: Make mce_gen_pool_create()
 return explicit error codes
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-6-qiuxu.zhuo@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241016123036.21366-6-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0126.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::11) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH0PR11MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: d932956d-0192-43a6-2866-08dcefa9e73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bm5YWUkvd2pxR3lsZnFaRHNQTVFObGM1UFN5V2hVSzVYaFZSWXB4SG15ZUht?=
 =?utf-8?B?ZFRLR2lFekFwZVZLcWJXZ2hsTUdBbENHb2dwaFF5T2laYU5TdzFMbEdoK0FM?=
 =?utf-8?B?WnYxWnlJUkRyLytKNkpCNW5hTFJrN2NTOTdmK2NyWG12RWFCbnp0ZWhJWGR2?=
 =?utf-8?B?SVg2WUJJUS9qMmkyNTU3Y1RkS3hCSitBR0IwVW92NEpNSlIzZ3FpcXVSQTBC?=
 =?utf-8?B?c1RXdVdZS1BCQXhNREpSV0sxUVkvTXlNK2VDQ2JweVdVMTArRTJSZ1NsVHVZ?=
 =?utf-8?B?WjRKSU14azZiY1Z5azVaWHpLeVlUdlVITElPOWQ3ZE1wQTllWDVPNmlsYzgx?=
 =?utf-8?B?YWZrcmpoTmFCT0UwSms5cFNReHVyUzAyeEI1WEloanJwZThEK1pGUllwR0hC?=
 =?utf-8?B?U0lrRFFsbHR4N1g0ekU5R0srdERRemQrTGJ2a0RIVk4wb05xNmRHQWxhV1Js?=
 =?utf-8?B?NXFiemRsMjhyS0t0TWJ6M1RicXJYa2NDMmZPQ0FMelM0bWpzZjVXRklJU1ZT?=
 =?utf-8?B?NDR1R09zZkJxb0srSEtRNjJTN3lYSFB4MVJsVDczWDRFdHM3anAyZzkrY3hl?=
 =?utf-8?B?N2svRkRpemU0ZlA5bU03V2V2WHVhZDBpdmZXYUs2OFdnWmoyd2F0eStUTDFZ?=
 =?utf-8?B?dDNYWEdJajdZbmtlWVRsQXBUcENsMFZwTnpzNjh1TWhDU043MENVbmlwYXpG?=
 =?utf-8?B?cXJsd1U4RHNXTzNPSW1JY2xEWHIxRGpmUndMdnhTQU53RVhUcldHd2JqTnRz?=
 =?utf-8?B?aTE4QWhEUjQrUlhqcDRGcGU3WDRyQTY3Mk1OZmd3c1JyMktXUDlKS252S0U4?=
 =?utf-8?B?Z3BZYm5IcFJyUHdDZmlPZ0s5TEQwbzFlMkk5ZFpWSU1xRDlvaEluZmt0SVln?=
 =?utf-8?B?VHZjZUxPWUhockhtdlQxTmlvWlRtVlJjOGgxU1NYRVU3dll2NWhHOHcrZW8x?=
 =?utf-8?B?Uk8zR1pXbS9ONkFyZWt3dzg1NlZjMGd2bXZXQXhQK3Y3Y25PVDBqUTAyT0Rt?=
 =?utf-8?B?WjAzakJVSFhmbWtXRUUxbWJ2eUI1bHJnU3hYODBiRzgyeVBFZ1ZrMUZteHNi?=
 =?utf-8?B?UTREbm5OcDBEZTBMclIwUWNkbWkrNVdRZVphSkI3dG82WWhVSDJYa3ZnTDVr?=
 =?utf-8?B?QTNXVmF3WlZCSTFSRVpiZmxhL2djVzN6VmFra3dTdElEVnlnUE01cGN6VEZw?=
 =?utf-8?B?WGxvVVgrbnlGSE1TVXB3bzk4QW1LWFZ5cm51dkgzRjcvK2hVN0tObHFaQ0xo?=
 =?utf-8?B?WTdUS1pTWkZWVXk3YmJqSWNRM3FRSXF2UmtSblVhZDR1SVlDWUpzK2VSU2ww?=
 =?utf-8?B?YktOQkRnQVhQdVJRR2o1RnpMNFR3b21mL3hKQmcyaCswY21SK1A5dmZiaVM0?=
 =?utf-8?B?c2o5WklzenRUVDZsOVpYeFUwWkFIbGx4Z0dqVnVKSVBsVmpxdS9TVE13VVZU?=
 =?utf-8?B?bnlVOUhHeitRS0pFN3ZlelY0ZE83SUxHYVA4UlJUaDNmci9aSHo0dzl6VVlm?=
 =?utf-8?B?VnU5NnJuRWVudnN6bUxpdllQNzFsNStwVWZlRTJHK1MrQzZBdmJWM1pSQWJ0?=
 =?utf-8?B?Um1rQ1V6RXZCeHpsdVJBaFRHbjJEVHpwSzdDNVEwd092WTVZMHRqcGhmdFpY?=
 =?utf-8?B?LzB5S3hUUm1xSjRMSzF6RXZrRDhTKysxYzYzcUU5QkFRL2lqTzhIWDZEMzhi?=
 =?utf-8?B?SmszOHRLeHJMald6UnFxQ0VFRklqOW5lNzVxMHNnclhCMWh3RWNwa2tzOVR2?=
 =?utf-8?Q?o8NPHIOX15/wWrW1zVxY1IlUo9JQHZviwtRByir?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEx2am8wNDJrSkdQS05FbWZBMHQzWDMyck9aeUxPYjN1SnpSOGZneXN5Umo3?=
 =?utf-8?B?aE5YS00wODg0YzIvYnY3UjlBSzFmemRsVnpWa2JsSW9kaEdOS0xkMWZDenE4?=
 =?utf-8?B?UlA4MENMZGpaODd0VGNwWUEwU1d1SklKVTc4U2hPTUVqaVl4V3JUNjZjTXJO?=
 =?utf-8?B?bUFocUhkVS8walNMYlJ5S3dGNm5qR1FPeHlXajdGZnNMb1ZOaDRzVUVHYzBm?=
 =?utf-8?B?NFluUmxJY0JCRE1jQlkvQVd6QkNRZkJjRVJVS0VjRC9pazFIOTNFZSttTHlY?=
 =?utf-8?B?SGJQNmFLQ3VRT3BpcUs1aHBWemNOUjRQcVVuSm0vOFZ2Y3VzNG4waG9iZXR1?=
 =?utf-8?B?T1h1UkQ1aVY3UkRHNUEyN2laSFJ0QXJXd0RtYnQxM21lOWxoSW5JaHZ6WjEy?=
 =?utf-8?B?MFJLZkx4M2pmMEd5cWJiN3VMNW4zbkwvY0VuWndKZGpKUXpuMitUZ1ZXZER4?=
 =?utf-8?B?RTd4YmlBS2x5VDZwc3R3Sk1DWklscGx0RHNNL05GQklBT1Mwb2k3c0J3c1Bz?=
 =?utf-8?B?NFpnUlJlbDE3MmtxWW4xY0x5TWhpTnNxUzlUbVdUbHB3TTBiOVhOK1FGMlpU?=
 =?utf-8?B?RWtlVTVtU2xmWjcvZzFVUXJUdjJoZWl5TGl0UTBLOVpNRExlcEZ4aWUyRXJG?=
 =?utf-8?B?NWdvN0pLNU9FNnNRS3RrRVl5ZWhmZzltNXoycjJwZnhnSzFZazk4dE1BNjkw?=
 =?utf-8?B?U1Qxc1VPQjJkMGpjLzJZK2hzTWhUaGJxczloTzBxdmxyZFBCV0t1TW50d3JW?=
 =?utf-8?B?RVYzdXpXVUxESXd0dkwrMGlXeXg4Y09sVS81dGZOWjBXNkVWdm1oeXgvTkJv?=
 =?utf-8?B?cGRZM09JYW1VcWZoVDZaZnVKYy9TTkZPbElJeW1wMDZBUnUwWThCS0NLRGJ2?=
 =?utf-8?B?NTV5dW5nUURGUUZkR3N3b0lqZlFiZ1VuQ0hTQXdOYzNnOG5UWlRPdVRJamxq?=
 =?utf-8?B?eUNaNkhlU1R3WTEzVVJkcyt1M1lycy8xMkRmem5aSklFQzJDWTM1NlhpYjkx?=
 =?utf-8?B?WXRNZlBaRktjdTM1RDArYjd3S1dScUhSa0Fpd1dSd0xyME5DT09ua016K0Nz?=
 =?utf-8?B?UERZR3djdmo0SWFXd2tJdWg4NlJ4WDI0K2NKOVp4TXpnVXZMbEJFSXdxS0ZH?=
 =?utf-8?B?VGdWWnc1YkhRY2UwK1l5bjJvNWhiYUd0TjJkR2hTTlcrOGVReG80UytjQlFH?=
 =?utf-8?B?My9GSDBlcUEvUWwzY0hrVTZqS2U4YXFZV1h1RmtQT09BNEplVDE4YkhSdmtQ?=
 =?utf-8?B?b2l3Yk1qdDVJWnhUSVZUVzZrTSt5NmZybmtxYlM5V0xoV2Zwemd0TkV6TGRm?=
 =?utf-8?B?M1pLU1R6U3dBWVhtOEJ4OHBFdkZDQXc1SGNGL1ZHRVN4QVI3T0c4RUpPNlNs?=
 =?utf-8?B?ZUFLYWJmV3pISVpHVkFlRVV5NktCcGFWVnhZL1dEOG1WR3hxZ3dpc2dMSWk4?=
 =?utf-8?B?R0JLMnBZd1N0L1FKQi9BbDR6WEk1ZWR0ZzRHTlhPUU9nL0hkQ1VsZndBSWRo?=
 =?utf-8?B?Z3lKTW53ZjRXS3FOTzBPMFdNaWpvcEpGRi9SM0xvWkJtNFhLeXM4N2tsdTZJ?=
 =?utf-8?B?QXNkOVJHQlRNOEFnWERicHUxSWpMVHg2cmYrclhhYW16bUxvcWN5SXp1U3Vw?=
 =?utf-8?B?dXduWjdXREdoMzBMYkh2WFJyYnpzazVoWUt4dWR2VTNxRXBCOGxHcnY1STU5?=
 =?utf-8?B?TGljK0NrVEFQRXFmZzBSd3FCcWxuYnAzaGNZT0owNEtidlBMdFY5RnV6dit1?=
 =?utf-8?B?QUxoN3lrbXhhdDE4bmJPQzVZODllc0o4d1FpRmp6bWpwbEFvajcycC9WRlha?=
 =?utf-8?B?UXBEc0RqdW1rRzFNSnlETWFQUlJQK0pDZldseDNRVVlCSlhkR2FKczNJZUVw?=
 =?utf-8?B?MmRjT21tdVc0ckY5K0kzRVBJVXVmdnlsRGFLbEhzUmpRbzRUWnZITlIvVVQ3?=
 =?utf-8?B?Vm9NbnRiNURMZEZ1MXVJYVhwcURXQ2FLcHNoSlBUSmJJZW5CQTM3UDVQenVH?=
 =?utf-8?B?VVhFdzBxc3dMNXFvcXNRNWVaRTkrYnBUNnlMaTNBWmpoN0NUTmdrVS85UTFp?=
 =?utf-8?B?bVp0MDNTbjNxNWU3d0VScGlCbE1uQ2JzYVkrYXdib21LdU9SeFZKN3BwM29Q?=
 =?utf-8?Q?+4BMz4p/dT8AJg05gArttZXjI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d932956d-0192-43a6-2866-08dcefa9e73d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:20:18.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbgWgtwsuj/ax7ZX0hCs0if4zqE8NGfBcATwuc5u3L4IyUesdgZgUwCzNsqQblgh0wC7vMz7pUqjNG/x/062rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4917
X-OriginatorOrg: intel.com


> diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
> index 4284749ec803..ffa28769dea6 100644
> --- a/arch/x86/kernel/cpu/mce/genpool.c
> +++ b/arch/x86/kernel/cpu/mce/genpool.c
> @@ -120,20 +120,20 @@ static int mce_gen_pool_create(void)
>  {
>  	int mce_numrecords, mce_poolsz, order;
>  	struct gen_pool *gpool;
> -	int ret = -ENOMEM;
>  	void *mce_pool;
> +	int ret;
>  

Nit: Maybe move the uninitialized ret along with the other ints in the
first line?

I had suggested something very similar but Boris felt that the current
code as-is reads better. But that was in a slightly different context.
https://lore.kernel.org/lkml/20240307170901.GBZen0re6AvpscLaTM@fat_crate.local/


>  	order = order_base_2(sizeof(struct mce_evt_llist));
>  	gpool = gen_pool_create(order, -1);
>  	if (!gpool)
> -		return ret;
> +		return -ENOMEM;
>  
>  	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
>  	mce_poolsz = mce_numrecords * (1 << order);
>  	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
>  	if (!mce_pool) {
>  		gen_pool_destroy(gpool);
> -		return ret;
> +		return -ENOMEM;
>  	}
>  	ret = gen_pool_add(gpool, (unsigned long)mce_pool, mce_poolsz, -1);
>  	if (ret) {
> @@ -144,7 +144,7 @@ static int mce_gen_pool_create(void)
>  
>  	mce_evt_pool = gpool;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  int mce_gen_pool_init(void)


