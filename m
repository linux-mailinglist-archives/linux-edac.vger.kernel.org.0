Return-Path: <linux-edac+bounces-2171-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D90539A9394
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 00:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB60FB215FF
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 22:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CB41FCC54;
	Mon, 21 Oct 2024 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZ3XpvBp"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C121E04AB;
	Mon, 21 Oct 2024 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551445; cv=fail; b=amtvBBpfI2+maFRYWoxrZM8dyvfVzNftRKTyou70q8b40gmRiR0tDYXtl3n4ZyPpqHbkyX7HShLsP2j7JnhXvLuGZ2PdagwrsVyxR5OM0JKFSDCtwu0Ooscy/CT8rpzpSFU6rPjnhu45zn1lxgrGLmTKFpBoDei2uVqAwQzNBk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551445; c=relaxed/simple;
	bh=RuVD9LkM6kuM18LoOyxv7dwwvrVIf9+oWW7qMjHYPBo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=axZWPuv9wFto5EASuND1BPa854DWZzsq506mzH8XjDARhjmL/6IfLB6ZDdBL5D6Pd7XoRh6TCFkzeAJR3WXBUglhnAOsTYWASxFtSwBqCGqh3VTbGUIhCpInhOEl9zD6e2EBd8IjDdc71c1vEiIXnqfUovsMdFi60czC4WyFbWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZ3XpvBp; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729551444; x=1761087444;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RuVD9LkM6kuM18LoOyxv7dwwvrVIf9+oWW7qMjHYPBo=;
  b=bZ3XpvBpcZcT+25h4BSrAMF74dwqPZ2tTzftz+thSGAhiB0PTEo4vLbx
   JqvSN31KMJVyYe9HvZ3izOXM4QPVB5KjXptF/+jcs6NqgYS6iJJyvmx7c
   hs//bitEmSi2G0AidXsXrkR7YlLSeuwMWiKs+JLDWasfxosLzYHSor6YN
   mIn18+WSUfngRv7sYT170uCabIM9fTre3/hCuWP/e2DnynPoex55GphDF
   45bfcM6w/NV3wE09kay2z96Lu9Zd6yzpg2qREtbl9VWSHbd3n+ZanmYon
   J9p1eRfCouJPwmikzvVlMpR6BgZ5rDqKm0QtSO/L0WfE/u7lhBsHx5uKG
   w==;
X-CSE-ConnectionGUID: snEKIH8SRcesbHNLUi85rA==
X-CSE-MsgGUID: Z7Mf7hp9QuO5ecXCdi9aCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="16689855"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="16689855"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 15:57:23 -0700
X-CSE-ConnectionGUID: PPEI/Cy/S/aZWEmddX1tAg==
X-CSE-MsgGUID: IljrJdsCRdG+qjSNJW4IGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="80013883"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 15:57:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 15:57:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 15:57:22 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 15:57:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPpQqYwVMQaSSe+HatDYJNYrbIHFohSQOT0NyQoJ3oEqYM0sbbkure5bFx9u/uZwfTniFSxcPj08kyfOwNsPrfojjBpn0Iefh2BZEjuLviNsPc2pIMwzYQr1TewkQcw7FIF/+shVuN06sleYG4otkaNlzaBSO3W7WsjgJApmpLEc4Hhun6yOJcGMmZdQ0KsumZ4YZH6nH+cUaPQVmEC5XerCzs00+KZ902cvVWa5LCDiM1wNBKnZseBDKMuhUM3hK/0G88QtFZrIRP8DCoT9YDxxdtlGy4iSOGoIFwHGD9cmNjFPujLS8/dOSrynaBrgB6yImwr/+5MgRiubXIK4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVmWyd9eO3HhBHk7RovhCHv3x2yyegbIWEOX0WoyYdo=;
 b=Ck1rjOdUlVg5I8pQjJJ0x5MQ/cPYELi3vzXK3UoPf0mMLAqWGLSKhikp1YK9P5uoxKQLFE8NZFcx09QGskSJwKSypcOefhBE9p2xYGRY4VQAMuLB260qM+ZgtZaesDkHCC9F69GPi59ADNpUN5K8BPG5voxeZb+ygn19tYfOvNyWdUZlYEIwjuX5jztmwB9ZHQJhHt9xkCm80MqL5QfAFwqgbFxQ3SdNfZNijZz5fbUc1SCtl/GZSE3uFLwvSX9rW8jVX9Tb0K1nQ1YszjBhHlQ7h9ZIRvbihAFqP8G30YqFFJ/Y2BwiKTJtPNoK0+nNfjisVdv2e/giuyg/fWPL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH8PR11MB6681.namprd11.prod.outlook.com (2603:10b6:510:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 22:57:19 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Mon, 21 Oct 2024
 22:57:19 +0000
Message-ID: <42d59ea5-5b36-49cd-b04a-4480064fff02@intel.com>
Date: Mon, 21 Oct 2024 15:57:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
To: "Luck, Tony" <tony.luck@intel.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
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
 <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <88e77a00-ad62-4670-9d4e-a146bd8b420c@intel.com>
 <SJ1PR11MB60832636201CA40AD13C02C1FC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <7a902c13-bfdf-4319-9e31-81c199ecf65c@intel.com>
 <SJ1PR11MB6083E463572AC9E110A7199FFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <SJ1PR11MB6083E463572AC9E110A7199FFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::34) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH8PR11MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 725479c5-772a-45b5-1a45-08dcf223b6f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGpBRHJDOC9hQ2FlVGsrNXBjc2VmQzFHdUlMcHlhcVQ3UkRKRk1rS3hQWFBG?=
 =?utf-8?B?V2F5dXB5cUhWdDZPVHYyRk56dnFFcWduRnVsSGdpUzBBNnh3Wm93RHFRK2xa?=
 =?utf-8?B?bWtIL1FlQTZzb1dYeStDeUphZDM3YXJyeEJSWjdaLzZZVmI0bHQvM3VlS29k?=
 =?utf-8?B?UXRNTXowUGMyWlIreS9nRVFJOE9IRFJoemdmNjRHaHZ0L3NHT3RIZUxQL2l2?=
 =?utf-8?B?d1N3N1hVSWorTXFaZVFIR3Vic2xYVFI1QUVCNVFiOHhDKzBlL2NlS0hhamNI?=
 =?utf-8?B?N1ZNSWsyalRlSDFwYUdjZnhHMTA5a1IvTldZNEZZRE9zUG1Ia0hoTzJTQ3JI?=
 =?utf-8?B?Y2JIbmxRN2JzQnp4S1k0eEdZcHFlSUU3UENNN1lINHRrdEYxN0J2eHRTaEN6?=
 =?utf-8?B?ZkF2VFd3Vi94TWthL3BXbWRWeUJVbDlZS2hXYi9lTmIySnozRFdBN1IySVhW?=
 =?utf-8?B?a3hRaFFWZ3JIRXRjNnROQUZJZ0ZlLzhGblgydk1ySzNvMjYzbkpuVUJLYnVG?=
 =?utf-8?B?RHJBZXNBUk4yTmNka0dMQ2hqTDJLb2I2U0hIK3g1R2pLd2VMczd5NFl5eEpB?=
 =?utf-8?B?TWtuSHg4Q3V5dUxkRGpvNXdxWVdBbyt3UFRNY1hRQ1ZjY3BWRGtpaTBYYVFj?=
 =?utf-8?B?YURjSUVlb29hVEFVMWE0Z1k5NVkyZ1I2QVhFc2R6MjBXYk0wT3ZJejlXRExU?=
 =?utf-8?B?eHNiaDBuQ0lPaWNBMUpKSDlGQThzcVdSVEJzN2dETmxyYWVoMkpSZ1hEQkRI?=
 =?utf-8?B?Nlo4LzZnNGJVc1pKV0N1d0gyMysrWDRoLzZNOGZDK01LZmdzRUZRN3U5Z044?=
 =?utf-8?B?aUxpQ0NzTlBtTWtqMmdGa0lBNXZsUnI3LzZnMytyQlp0ZzB3VE9Ic1Q2UnN1?=
 =?utf-8?B?eU5KUW9hQ3Y3YWQ2UHN6M0JpRXNrQTBubnQyQ1NEWEhyU0xtMWtEdUJETTdO?=
 =?utf-8?B?cGtHV1pVZ0V0NTRjWXhQK0h0aGlsU1hFWml6WnBlME5LLzUwOXBHSHQ3dGZH?=
 =?utf-8?B?Qy9XL3QyK3FyaGprRHJrWHJRV25DdkVJSVExMHRZbnU3ZG1tUlliaWsrbkFo?=
 =?utf-8?B?TlNhOGI4LzZ4WWVSSW1KdG1TcmNrZjdOL3RSWFhlM00xMzZsM2gzdCtWYXhG?=
 =?utf-8?B?bkF4SThrRnlxYk9hbDYydEkxQUZ2OFI0K01UaTNvQnhRcEhsM1BhN2NzNllU?=
 =?utf-8?B?cEplenNMaW9QQlJyVk5TWS8vMmdoWmlCdjdXS3doK2lKWWZlTlR0clFDUjJX?=
 =?utf-8?B?VWQrTmZkM0tNRXh1WXRSZDJqb2tCRHErajVVV0gyTlFKOW1Sekk3RXluZjFJ?=
 =?utf-8?B?STYwWE9CMGlUNUFaQ3pQeDZMSFl0MWZNdzdZZjAyWW0xVzBrUHFOcndkSUtz?=
 =?utf-8?B?c0FZaXdrYWJDZHNNbXpudG9HWEJDb1YvYytzQUFWZ2hVL1QvUUFmTXl0V2xJ?=
 =?utf-8?B?SGkraHBaSUhNeUV3STMyMENudXJuQ0RINm1lRHZpdGQxamJMT2ttTzY3V1BT?=
 =?utf-8?B?OXcyeEJOU1BaOUtoWU80c1FwRmpwMzNXTGJtbTVzTDR6d2R1SVlFU0ROVmt0?=
 =?utf-8?B?NFllSElBblNJZGVSR3B0VHNXdzVnbkJodHJoNWtIb2NUZGwrSmRTbUVnelFI?=
 =?utf-8?B?b2I0SmdkSWtKYjZ5YkoycTNoa2hTckhIdkZiY2JvUE52d0p4VjkyQXMySjZS?=
 =?utf-8?B?VXFUYzYxOEpnQkxPZVA0NGZ5K0VBenFrc2RlakZlQzVVaFBZUlBteUhXekJI?=
 =?utf-8?Q?syLukCLLut4SZhIgoNe6KgVjIGxqe0pR3zFAYDo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFVOMU83a2tMYzBGSmJ4VmhHN1BOaThPbEhpdzNqa0d6d0ljNjZHU1NsNmM0?=
 =?utf-8?B?WU10QzNBaXdNRXFWOUZGSGhpQ2JsUW9sQy9vSjB2OEVyMjljVmtLNUN3Y2NQ?=
 =?utf-8?B?MVBYTWpjZWpnd0NpeWR5TXp2NXZteHU5ZkNlMzhRcU9uekZBeXQzeVZRUjNt?=
 =?utf-8?B?WGdWQjdTQVpROWQrR2t1aVJtZzZEQVREblFpc3g3MzVLR1orMlh1eGVQUUlU?=
 =?utf-8?B?d0d4YUZkYXIzV0hzR3JZNG0yd3hha3FFYW9tNTBUbnozQmZLN1ZxbTc4YkhR?=
 =?utf-8?B?VFpEN1R4NGR0NkIyeWxZakE2T2tOYjg0dE9KOXhqYStWTm1Zbit6KzVKREdQ?=
 =?utf-8?B?b0FIa0xSTTVIR2FjRnZ2UFNuMG0yb2E2WlYxMURhbzhya25IRk9VOWlpbExG?=
 =?utf-8?B?MFBlWG82YmN2aXczTzcrRWdXM2ZwRHl4aXZNU09uODg0bkFQdk85OCtDR3FQ?=
 =?utf-8?B?aGxFbCt4ZmdUTTBGVlVoQlg3MVJIRUZ0K01uL0Z5QXo3RE1jTW9PeWxNMERt?=
 =?utf-8?B?eDRFQTlrUlVQc0QyQWF6alptRjhMNXB1ZXpMZ3daMTlwSWdjbERuUHFzRTBC?=
 =?utf-8?B?K05BZXVHV3R2RmdMSkc1UTdqdWdtM2l4ZVptQ25vSGRvb0UyajM4aFNqWjlw?=
 =?utf-8?B?bVlUdVZkR3dGYUVaS2JxOFdEcXUrWDVOZmYwZithK0hHTGFDV2V5Y2ZwcTZM?=
 =?utf-8?B?dUJJU2lPZS9BQXRrOUx4dlpHQitJeU5venNUZW5TVDM1ZjVMalFjYUNwZWlj?=
 =?utf-8?B?YXExb3lwbjlNcHFDQ3VwZ0hLb0V5VHp6ZGl5VDJTbStVVHhYWjFaRU9McnE3?=
 =?utf-8?B?RWJvQTArVURqWk9JdGJuMzJlR1h0RWtycG9Pb1VFVmVHbmd3ZzR6S05EY2RQ?=
 =?utf-8?B?aUdIRVZSWEtXb091WUttSFQwY1dDdyt1SUc3aEZmdWVwbm0zK1RSS284ZkFz?=
 =?utf-8?B?NHFaS3dCNzVXcklMamNIWmowUnIwb0tGRlVkOFZwcHhPV1l0TGc1a20zQUs0?=
 =?utf-8?B?a3dnbktiU3lGK0RpcHBqTTRlK1AveVJQaStaa1NhS0ozZTEzWEZtTUhzT2li?=
 =?utf-8?B?Q3Mxb3pibVc3QVM0R0drVm9VV0hlR1pQYkg3SVltZ2VBc0RQakpEZ2NENFBY?=
 =?utf-8?B?Znc2b0VtaGR1MFlGMTN1Rm1qaVh2QlFudzVYdWdHMXBGQkdiRnJ4MFVROG8r?=
 =?utf-8?B?azNIOTFHcmZSc2RjaEdCWDhoVU1jczNhM05sUDh3TlZ6RTVvZHIrN1R2dHh2?=
 =?utf-8?B?N29SY3Fsb1dTTmFBSFVrZVcxcENOOUU5NlNIaEduQklXUG1nQjVCdDFDTTF2?=
 =?utf-8?B?enk0elJReWNrOTN2eGNaeml4UkZiNEZ4Rk1lWXdsVUR1TDc1K0JmZ0Nlb2dU?=
 =?utf-8?B?K3N4S3hXS2d5TXRsUVpwMGFDejRURWlHMTErZ3NYUWt3MklvVU5nb2JLb1gy?=
 =?utf-8?B?a1oyUjNCano5Vm5HR0ZMOTZyTjAwMHl3MVRkUys0THI1VkhobTQydjd4dE9q?=
 =?utf-8?B?cVM2YTkvdm1Bdk9RT3BFWlZ6RmtJY1dISE81TXY2ZnJDODhVOXJsdWZTWFlW?=
 =?utf-8?B?UFJ2WWFNc3pTSzJTWktJcXpKekR1ei9BSDdyUmtkVnRRUStxUm5vdTlaY3ZT?=
 =?utf-8?B?YTBLd21HNVMwQ3hjYmU5UlFiUzNWZmtSL1R3R1NWRDlQamtZY2o2RzVFVmN2?=
 =?utf-8?B?NDlEMTM1NmYwcmcwdU5UcWIzVHdYZzBRTW1sRE5ocG1veFVkZFpGSnBaY1Qr?=
 =?utf-8?B?RnNlc01ZUVZieXp1bDFtTnpxTk5qZ2pDRENwTzB4Q3pMUmt0NzFtditKMFRW?=
 =?utf-8?B?bHVsOGlBdk9WaXdlT1BDRmtHRUFhV3FiZWJzUTJOZUhwWkcwNzhJTWNTN0xW?=
 =?utf-8?B?QXFNdW0zd29QVHUzaEpRQkw5N0QzMFlUdklKYlBxM25ackFTODNGSjI5NDhm?=
 =?utf-8?B?VS9GdmNrbU9BUmoxdXNRbU1TczlkU1FGV0JpdjB1NzdZQTdTVThKUmViSURk?=
 =?utf-8?B?N0IrMGtCZlhaRGRmbU5QRU5vc0hsUUtvb3NTaTdlNWpYbjNraENGdm4veHhT?=
 =?utf-8?B?NjQ0WG1Qa1YzekkwcUJqWnVsdzhBVWUvRXFIWDA3Mml3SDJYdUxLY3ZlMkxk?=
 =?utf-8?Q?snD2MvKp+cJq+lDUuXA7kQGSu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 725479c5-772a-45b5-1a45-08dcf223b6f9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 22:57:19.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXa28nvMNDcq+/OG5z8UP1fEE7WkCGOhQ5lo3QdZSakIeuF7Rd4QI1eUWkk0bZH3H32LKmIBQF723oSYb4FBTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6681
X-OriginatorOrg: intel.com

On 10/21/2024 11:40 AM, Luck, Tony wrote:
>>> Intel model number allocation policies aren't necessarily sequential.
>>
>> Model numbers are assumed to be sequential at least within family 6.
> 
> Assumption can only be applied retroactively to simpler times.  Looking
> at the timelines and model numbers for pure-Atom, pure-Core, Hybrid,
> and Xeon, they are somewhat jumbled.
> 

Agreed. Using range checks within a family with extreme care and
avoiding cross-family ones seems like the saner thing to do.

Maybe everything in the future is enumerated and VFM checks would not be
needed :)

Trying to understand more, I have more questions than answers. With the
introduction of Family 0x19, do we need to reevaluate some of the
existing model checks?

early_init_intel():
if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
    (c->x86 == 0x6 && c->x86_model >= 0x0e))
	set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);

It seems "constant_tsc" wouldn't show on Diamond rapids. Do we need it to?

> Qiuxu starts the function with:
> 
> +       /* Older CPUs don't need quirks. */
> +       if (c->x86 < 6)
> +               return;
> 
> So Quark leaves the function early.
> 

Ah! My bad, I missed that.

> -Tony
> 
> 	


