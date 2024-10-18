Return-Path: <linux-edac+bounces-2145-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8649A4831
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 22:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB60282158
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 20:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19592212D1E;
	Fri, 18 Oct 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlDJSDA0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8703020C017;
	Fri, 18 Oct 2024 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283682; cv=fail; b=oivL/zcOH1sKfA1O1lxgdwT2Zu3/lX/DWUFgrbQHT8QxZQDFQKFz1vH4Vj5y3qUOGKeBogE8FI56Kmlj0+xaXkCibSwu7ZxM4QylJe4sbo9MW8b2Nhjl2wQAXCg46fgnIzqo0zr8XTpdggbUrid4mDlBXUEUpckA7cAjKMw9S0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283682; c=relaxed/simple;
	bh=9wasOEYfxNodhiyPfCPgaMMVRFb7Zg7RULC8jk+wFsU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UICdrEbUp3P+QsP38haUb/fULC5Ono+AU9Amsu9fPxpEdZY4jSFROvYV1J38ht0RHxpWScaHHKpYkrsK7U3k1QSrJEf1pY0ffjYKJ+mx+6jP8+H4gyMtmKY9ty5/SkOOhg1hjDxIKJW9Ao1alLBmK5yrV9AG7bag4xt9QtE3SMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlDJSDA0; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729283679; x=1760819679;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9wasOEYfxNodhiyPfCPgaMMVRFb7Zg7RULC8jk+wFsU=;
  b=HlDJSDA03D0Kbo+U2HOoU6MvkEQbn6PepmjPydfmnDP/ZjHUV57p8e/3
   RS6XXJjtq7xVlgqcYPyfuczpAwV8hFMVZQXKS1ka4+DMUx7GJqBAceUtj
   udN/Ds1veSvGSeyk1yNrVvTR1mR++9GJiK52MojNQcSOgVMigqufnyEiI
   +NLEgCnnlOEl2HaC1C5UPFtkQUSqG7xmfvBQ+BSCE+z5zaB4SiSXz5Wd5
   J3VorCLi6rsoWgrfkhJSZYsxZhvAtw3Twq/ILELKcSAK7+er4ZXQ0BFTz
   ztmv+2mM3uVbR73OGTRWacOC4aU17sfvjDbPpkDmxb+HFP9Rteomo4dlR
   A==;
X-CSE-ConnectionGUID: J528BiF8SGGFhR57XS/Neg==
X-CSE-MsgGUID: LkleaoJyRzKHeDfzb4jPxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="29038347"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="29038347"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 13:34:35 -0700
X-CSE-ConnectionGUID: 1HYYfwLXTJ2r8HmU7LXHUQ==
X-CSE-MsgGUID: KRd3ef60R46TJjxweL1K7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83765323"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 13:34:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 13:34:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 13:34:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 13:34:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 13:34:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPYC35d1u92T69tdiF38YfDH8eIJ4yzgSJysEENOBe+0z2KLidrLvWTdk/TlCx7NZJaM0e8Hu4BYya5nGblLj/PbJJDV6dvnA2ihRXBY9UyTaAFSieKbtmTtK+GqsSIyprFnkjJf2HHeVltmpFg8Z4ZPJLl2zBumIf9m+V8EArPn5Dy/lN7GG1/PBnBdUO/DguivuPPY37s4mNdi+dqZefYsf/w41oFxrPKK++YQJyIw1LDRag2mUdIzWEWrznryl4ClqQ3rb2X9gufZRz/u6J4qg79tAU6iJ3bzpx3VhWVVrK4XY3HrJItFFIw+FoQFiV1PsPVS7vDWjZ5ri2GmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOM5hKPN/MnAfjycdrkJjXrZW3f36JSkOxzWxsDca7c=;
 b=iMgogD+4pt1u6HIM4GYCsYTypFnpn2zsqNe6RXo93vnW1Svj93uriJhE2X8p3CFIPE/67SXygOrXL15Z0cNbX0nYe7llUqaVpXEwq6R1hgxPt6n4QojDE57jJwI2V8b/kvRvuE2oCGK6yFRX+OVIBO04IE8TPaj70GsxMA/2q/ugwrwXJ5uRbMyamy0/FJ8ubSBNgyf/f4IjaBRZZvXP8P5sgF0ZQarjzByXbdjxNiZ6NFSBX5pAQ1A8nON71lTf6ayq2XiK3ymoYuHtC+yN6vVlumBxUfBuBn4MvY5z00WlUdLDyxOM7q+kUh5Gz3eqGbWlDsdMBprmzUBm2Kutzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 20:34:31 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 20:34:31 +0000
Message-ID: <9097a674-4525-4bec-a502-65d3977e1647@intel.com>
Date: Fri, 18 Oct 2024 13:34:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] x86/mce/amd: Remove unnecessary NULL pointer
 initializations
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-10-qiuxu.zhuo@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241016123036.21366-10-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::26) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ1PR11MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 0031d577-36fe-4155-a716-08dcefb44547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjNpRGxBSDN6RURHZ25aL2svWDVZTmJTaUpQY1FWQmxvd0pJc1hWS0pKQlY1?=
 =?utf-8?B?VzdSZW90QUpVeGR4ckQ5RWdTWk9iR0d0b1dLQ0c0ejdkemxoN0w1eEFGYWFi?=
 =?utf-8?B?eHlkZVVOR1BsZTNtd0ROOVZHeXdzdUFMWU5GNm8wRTVLS1hYTGRneDNiK0RL?=
 =?utf-8?B?bjdhUXhhZ3JpY2NLS2NuYXc1SzBUNlhSU2pnNmtpcVRhcVcvSDdEOEFrdFRI?=
 =?utf-8?B?TjFmUEI1SXpoWHhuY09WeVBnK1l6ZVExcGJPcStSeFZNL0x4R2tYMTRNelB2?=
 =?utf-8?B?bWVJTnNxOGFERERYTTVsUDJ0cW9aMnROYS9XZ0pRZVlwL2FvVmFiZ1B3dE9C?=
 =?utf-8?B?YmFGdUhTcmk2aFduSjRpaTFNM29TNm40UFVKVDNhQWVTUWZyTGhEc1VIc3Jt?=
 =?utf-8?B?emd4MXdReUFmeDFPdlFZZUoyUEs0Q2ZkYitvd0g2T2Nwb2Y0ajdta0hDK0Zh?=
 =?utf-8?B?ZGR6MWpoRDljYXdaZ2pkaC9oNXZ3dzgrUDRGNG5xSjIvcW5KdURmNnhqV1Zq?=
 =?utf-8?B?M1dlYUJaVktoSFZnMEgwQWZ6c1o4SGxLNnNSby9McENJaStXa1NtYW44czlW?=
 =?utf-8?B?UkhZcmN6RUZSVDBtKzRpUXU5cnJ0cVlPdmZGVURSejU0VUNGL2M4MU11NFNH?=
 =?utf-8?B?eGtTcXV6QW1ENXJZaHdHRXVkdmE2cUxtampsbEtNajFWTXZUT0NWcnJWeUts?=
 =?utf-8?B?OXdwUTBYNWI3OHFGQkZ2enAwQm44L3BrZHRhcDJBNTVzNjVwTVNRdlB2QjAy?=
 =?utf-8?B?LzNCNnlIb2l1UnBoK0Z3SEp2NHNCTlE4MHFPTldvMGxKRXFQT3JUYzBYVnpN?=
 =?utf-8?B?S0xJVE5iOVp3Y0doMG53WnNFblNjVjVHRDlQSWVNczNxelV4UW4ycGE3SVNP?=
 =?utf-8?B?TjhrR3pLTHZrWlFPMCtUQVgxd1ZtZHBCWE9sdkdQN3JZcXBqd3YwcTZ1czZa?=
 =?utf-8?B?MkNQemthOGhtSFIybm43RUs1dEUzQ2FsaDdiNUtpbHhKejZaN0M4a1NiUktm?=
 =?utf-8?B?UHZZK08rUloramYreW5DYmxQTmYva0RWMnM2ckRhWjdkOWZPRWdIMkp1bktP?=
 =?utf-8?B?RC9PUWpqZlJCa0w3eGRCa3h2M01WbDdUS0Z4eG02bWpEYWVGd2gveklXZHo2?=
 =?utf-8?B?aGZjOVMyUnlFVnhGdUtSYStHNHBlcjE0dlp5RnVVaGxmcVkySDBPQXhZNTdu?=
 =?utf-8?B?Q2xrcFFQN3VTemFlMnM0Uk15VnR5N2huUkF5MUVWQnU4bXBVWUF4clpuNVJi?=
 =?utf-8?B?d2ZiR2lwZVBVdHhBemZyMGtJWUxSeG92WkI4YjdtVCtKa1NpZzQ1NllldEJ6?=
 =?utf-8?B?Y29Ud2prRWhVUWdvYlZrbXlIZC85VmFQTnFJSzU3aEd1Mm5PZ0phMlQwSHdu?=
 =?utf-8?B?QU1kOWF1Yk1kNnNaVGRyaEozcTdmWTZEQVlNZnF6TG9UTUFFTEtlTjlzKzNo?=
 =?utf-8?B?NjBoS2hoWUcxZ3FRcjAvYmNGNkwzWDRrZngydVlIUlBCMlF0U0ZwOEE5NDBm?=
 =?utf-8?B?WFBjQXFya1QzRjgrSFFnTnU0bjNyMXIySVRkTWsyc21xekJzcERVOTY2UnpB?=
 =?utf-8?B?aTYvOStFWFRPNWNMbWJvekxIWjBHODd4T05vcWJOK3JnMmkrR0V0Z2RnellO?=
 =?utf-8?B?UVVLZlFNUWlaYUZUeklUc3I3R3doLytISTJFR0c0cjhCanVYK2N5NW5wQndi?=
 =?utf-8?B?WFZBK2VocDJTTHhIaWlLK0pJM3lrM1kxMUdtSVkvczU0QUEvNFpHVGQ1SklP?=
 =?utf-8?Q?QZTHPlBm1s1bptg04whEqqPWPSo/ZZMm9DnN+AY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUZQOHA1OUNNZ2dnWXZ1ZDdsSUVxei9xU3RkVGhQaFJPUmtPTE54NlBkYkJy?=
 =?utf-8?B?dDhjOHIxdnMvaEtQRW9vOTYvM2JkQWZVcHN2VXJiRjFOK0lVZHhKV29ranB2?=
 =?utf-8?B?WnV4TnU1NDBYeTlFRkkxNXhPWGJsY0NiTjM0TDV5TVhlNnJTZlNFdEF2K055?=
 =?utf-8?B?SFhTUjRqeUlGY0x0MXhNYnBmTEY2dU9SNkduN0hDdHhtbHlYQnBuVzB2MWUy?=
 =?utf-8?B?bXdiOFBhR0MzSGVUQUhjZFlGczVXeTIxTVFFazNKQzJKVnZPWjhybnNMdDR6?=
 =?utf-8?B?R1EvREYzRW9lNUltQmljOGQrbHhsYjJSd3RrTmJ3MFVzeis5M3pkNUJwYWp0?=
 =?utf-8?B?QUZOZXExeEZHY2FnVS9wVktKSThYa3NVbS8vcXhvVmhlakc1OUJUUTBoSUtw?=
 =?utf-8?B?YmVGV0tMTkZxcXExMkFUalF0MU1FTy9OeTlyNjh0SFVxaDFIbnkzSnpsWEFa?=
 =?utf-8?B?MW9maEVvelNKUWhQNy9Hc3R4cy9RbEhZU2MrRUltSmpnNkRLdTVETnlJL2kr?=
 =?utf-8?B?Q3RqeVRuM283SnlYU05CTTMycXE1QlNBdDA4ekpjdnBub1hNbkR5cUtET1Uy?=
 =?utf-8?B?ZnI0M21hOW9vdTM0VE0zVXkxcTZCVzhXWkk4dk9yMUIxOWhQOGF2M21ENXRV?=
 =?utf-8?B?NDdzOHdtZE4yclcrVzBPMTFZdGhIVnYxSi9mb0ZSK3NTbk5jWDdDWUJJT1Fl?=
 =?utf-8?B?Yys3bGluanQ1QmttN3o4dE4wWmRqSmkvRkRjS3doT1A2OTZQdTRtN1M4dFpL?=
 =?utf-8?B?ZHdvOGNobmxpNHdMRElaRksxRGNCc3QvcmxPNnhJQWdHNktTOHNxeDZEczht?=
 =?utf-8?B?OFl0cngwd3MxNnpBTnFCYXZMS2xPbE9MV3hmRGd3YXE3RllpUzdrVG9YZnNj?=
 =?utf-8?B?WEFyQ1hFWk9udEFtcy9KVFl5Y2FOWWZFNkZmWkthUi9OOUVnZFR0bFhhVjhB?=
 =?utf-8?B?QVlOVFZmZXY5SW9Oc2lYMVJDWW85NGZSMVZxTGJ0dGk0SUprbWx6RVQrbnNU?=
 =?utf-8?B?SmxPM3d1Y2lFcWhLanVtM3FEQm52d1drNUkyZk9Ebld3R2l6ZTdxL3RMajg4?=
 =?utf-8?B?SXRXUlp0ZXZSZHZRSldnSjRsWmIwWEN6QlhaL1RYTjdJMzFrdUZuOTRvNWVk?=
 =?utf-8?B?UDFLa3llRWtTZi9JNStxZVZsTnRkU0hrT0c4TUo2c2xkSlVsNjVRM0dpRERN?=
 =?utf-8?B?U1RScndnRFh0dkhPYkxEU1IyZEsvaE5xWU16bWlWOC9VN0VNb050TkloUWsy?=
 =?utf-8?B?bStBdmZLVk4xUEEwd3k1RFpqenVCSTA1QXY4UzJFNTVRbllycnhTRGtHMXZP?=
 =?utf-8?B?bGlzbWNQRU9FcXNVdm92ZlRlcitsbzFRT3VQRFJISzdaK3VaWTUvRHU4dFZJ?=
 =?utf-8?B?cHpYYXhYQXVxT2plRzFLRk9rdEVDeGo3QW5yNnRmRjJXTkhoNjVWTStzdklW?=
 =?utf-8?B?OWRZWFBGK2hpd0h5alh4cU1yaXJOa2M0eUVybFNIaGV5d005dVAyYjN1SlZS?=
 =?utf-8?B?dnlRWkhOY0NtbXI4V2hpOWFjSkpmSEdhT3hndk5wZHc5UzhuMWd5NUFVTm9j?=
 =?utf-8?B?eTN5ZU03N210ZDRsMTJ0OVpZaC9SV3FScVVKaFd3TElYVzloRzR4U0pZUXhP?=
 =?utf-8?B?SDRUcU5hUlprenVXN2orWUhOSmxVelZoSXRTWjc4OVF1WFFOc212UTRxK3lz?=
 =?utf-8?B?V0thNE1zWTM5WW85QnBWR0FVNjdnK0FYRU9JMEdQMEVVR3dwVnErc09zMExq?=
 =?utf-8?B?MlUzOWFzNm5JU1U2TjRlR3ZUZHVnajc3QmJJeW9seXBKaHZ4VmVVY2wvWnJx?=
 =?utf-8?B?L1dqUitLeUJlNzBoRy9ISVZUaHBiNCtacUZMTHk3Q3dGZm5TVjNkY0g0K2xp?=
 =?utf-8?B?VDdBRXB5d0NuQThqTDFYd0lsSERkUG9kQ0dYSjJlWklFSWQ5TVk3bjdRbkU4?=
 =?utf-8?B?R0tadVUyUSsrd2NvUEp6MklSM1Npd2xQYWVaWjJKK3piVEpvbFpCemtKNEVD?=
 =?utf-8?B?dk5LRHlkVVBMdVN1WXNiaGtqSWRKajlvcXNRZW5oMHREMlNEalEvNDhXbXRP?=
 =?utf-8?B?NWhuMHRIbGc5R3MyYm1PMFgyMy9rRmNJdmVRSlByZmdTczRUWmdualI2RHF5?=
 =?utf-8?Q?0gMx1CdC9L74x3FNmtWuEixLy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0031d577-36fe-4155-a716-08dcefb44547
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 20:34:31.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3TjQoBlwMex7ojFb4nmbGB8Agy3ahbqb8FdtiuztoZNBjGqDrTbSePMS+UQK5djTyGtVoJp9ewvJUiqhCH12g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6201
X-OriginatorOrg: intel.com

On 10/16/2024 5:30 AM, Qiuxu Zhuo wrote:
> As the variables {pos, tmp, block, first_block} are all initialized

This level of detail is generally not needed in the commit message. I
would rather just skip the {} brackets altogether.



> prior to their use, remove the unnecessary NULL pointer initializations.
> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---

