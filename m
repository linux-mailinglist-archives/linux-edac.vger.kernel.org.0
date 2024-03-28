Return-Path: <linux-edac+bounces-845-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D6B890812
	for <lists+linux-edac@lfdr.de>; Thu, 28 Mar 2024 19:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D539298AD4
	for <lists+linux-edac@lfdr.de>; Thu, 28 Mar 2024 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0323BBF9;
	Thu, 28 Mar 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2t9W3EU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC51879;
	Thu, 28 Mar 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649690; cv=fail; b=LPn84vi3Q/dhIWsMlg5znC6Fu7yWH3dXhgPdwbDYlMSCUSX77eB5HJiyZlUuQhFj7oqDHjqLW7XUXM1dbe7U8AOilzUSeWvu0/XMaECC2kOMcae96nqRscqt4OiDuflJ80vcnvJIEuk5CwZzCCt5jaFuXHQRRiyB+mrsUfQNnrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649690; c=relaxed/simple;
	bh=pOzj8sSyr70UwNCATKzpyEHMKW4odYg0qLuc2FMw/NQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LsVQuibeda1qo0e/WO4UXaCN1p5zLYrs/R6CMxO5rHr7U4187whdD1euFuwHanjzlpj9P0Anex6oqcE2gQJJBBt6OsJXjVhPA8EoMjNzYWYMXP2e/7NrOE7eRc5b2ltLaB1Kv+2vag8Jl5/QI7p+k9IbrbpE+jOLZxiQBSplTNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2t9W3EU; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711649689; x=1743185689;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pOzj8sSyr70UwNCATKzpyEHMKW4odYg0qLuc2FMw/NQ=;
  b=F2t9W3EU7VZR3CrgYuHkwrv6hemn1ajGIphmKixPJ1hBNfZifW4bLSi+
   89ggiKwXGHekfQ+Y8ay+aSrtGUOL7H9ZQfnxbhZYehaRT6wSET5hq8P9c
   eOHJYPa/Dj1aLiREEbZQEseqGf5o0nEdEsz47dHi2aC2T4kQBeIa9jRAH
   Qk+qnHEsW1VnVRGDIK/n0Y0A5iTx2AmZ0jjvpw53if2k1j6nfOBE/lpyP
   Xuh4nSMzkDlY2xWM6QUbAHM3l8RsClC3PIIf6c2KVniHj6BJkOBKtn6mU
   r9+O8JSZDaQB/h6lLDlNNM0kuwEccI04c+/mMNAQbeh/xc/6wKrSdPP8+
   g==;
X-CSE-ConnectionGUID: b87AGNgrT5yfuZRIVVsBEw==
X-CSE-MsgGUID: OFQUwXLPSqGQRBWCdNjeUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6936098"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6936098"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 11:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="39887970"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 11:14:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 11:14:46 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 11:14:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 11:14:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 11:14:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS+cBvsJOmCCHfRJ1lHZZQXujjYV0Dn5H762oGEOZu9mIIRakYWf5VVm+ggW59TMwyC3EwgHJi6rChNp35O+xz34Ir1ZERVWlDkruR1x9DdoYLcvgjJRTcPycncSHLwTuMjteSQX2pwPbhURCa8dX+dsI3uVkPyWYC6QuvDpkv4ziQ5q4iiK1a4otO+3LDff0BW8Ws2jNCNMBWvmvkj9vaQtsKf4Aohjcz1P2KOzOu0M9JwC3XsjFjCdpcw0NV/lCZ6zMlSQi1+UNpnPhr0hvVD7kVjxCp0LfoIhC1O/Xl3X1HmMvCS+idxUW++m0vRmJe+KrhWF5V8rXKtySyUr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aClHq6lHXTdG37yiLWki7Py6ekzuhkb8BihwsCYKuSc=;
 b=WQHgVD6fbA1QGfIGkz/ywISSchegCEIGA3WK0endqmYgHFksOQqRS3Bg8Gup5XbhdSY3vkAOT5vySJpPJekKCVdbshYqn33U43iLsZCTgrAwdnPT9ENNqRUzMYcaNQtD6UxJaMJl1hOiWJgrWOj5hi5k6Nq4VQgbs3FED91NwbnQMPKEqtakqNp47ge084SdFfECwTxosnB380yBG65uKY8gf0jA/f+5lwtZzPhmv6yjM5dHjdFD+7k/SV5qKrjiRD6A8MBZAaxKAKs9nWTsQN6aJcmBoQvl3AxpYDPVmWiUl45j0jAufXTC4UstkXNy0jFSikrmgL5l4ykyo+bqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by LV8PR11MB8697.namprd11.prod.outlook.com (2603:10b6:408:1fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 18:14:43 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a0fa:3852:360:63f6]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a0fa:3852:360:63f6%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 18:14:43 +0000
Message-ID: <9640d452-c591-495b-8284-92f7f986c97d@intel.com>
Date: Thu, 28 Mar 2024 11:14:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Update mce_record tracepoint
To: Avadhut Naik <avadhut.naik@amd.com>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <yazen.ghannam@amd.com>, <avadnaik@amd.com>
References: <20240328180435.435076-1-avadhut.naik@amd.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240328180435.435076-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::30) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|LV8PR11MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0f1d3b-b466-4459-4620-08dc4f52f13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roYhc88C5785w9A2hfoUoglJ0Pb2056uuODi3/6qEUBesMYPaRXxb6jxYWTClOHa+YIAWhseE9Cnq1r5sCClKBpuYtbGTQxlluC2AHh3jHvWjBTdmjETz5EzIaHW/6QzPuF0lPl4rZ78f1GuHloQ6JiYP/bEiZ3F1oi44jOiehpDFc7o+57p5E5oQafc6dRz7T22/9B5Ucnz6/IZtusF0ggqkgrYWVWvm23HgCuBpS0FVm0LbPg+afaMOVG/dYokjstqKyi2lrDGnplOaBsuCg7eqy/eLNtrmGYvq5IiVs2mXHMGn8jHOz6D50+Cs0fbKpbR8wft74IrgNo0Ur8yvjcJaUo+pFIET02g3d/ubxux8hecGZLp4fg09doI8YGj3Onnrjhb8DIZXz9RBK6Mk0Rmz5USt9C43UYeVuNSwQ88wCYRcYpuKXCnK2gQEbkSMP0fzuOa/0e79S0lZ1kBD2BlTadADPCV9dkXbqDd1qF6jxVgPbdDveAAt/p9v8QtadbrITFRNucDi/7vB5wr55DGnC8GjEEOpc3rrCEZggtRT7qG2CUOB2iQcjEFK1AnB3ymydeqiRQU1R1H+jLAWg45DPGvxyufwgrdNMN6pRKD5dbMhc95pIW4mfrG06HtdSXRyOy/1pkgQipVr5lJxCvoZP4rTXn95HWZlHZ8EII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnVZWjFwZkluS0VVeW5McGdWbDFCNmVNYWh3dW13cVp6ZkVOQ0RpSVlab2N5?=
 =?utf-8?B?MVdDck1pc3J1clRCd0NJSW9pbmF5bDA0emgxTkcxTGQyd2ZqRk54eVlQcG9S?=
 =?utf-8?B?N2hOS1p4WXBKWWJWbU5HSXQ3ZHpmUXFvVFVGSkNpUi9jNlVaNXBpajM4RnlM?=
 =?utf-8?B?SVpQTWdvMGw2RXpuOWZnRjNDQjQ2K2lNMnl1ejlMOFJrdGcwSzBQcXdYUkNY?=
 =?utf-8?B?cXRDVTdET0NkaHZXWUVxcXVyak82Q1dnbzBIQXBsT29Xbll2ZzhibUxUajVR?=
 =?utf-8?B?QVpvMy9VZGY3d09pNkgvdjBQell2TVA2b2RVdWhNQ3c0bjFEaGo3QS9FZkxM?=
 =?utf-8?B?U3VzZTh2TkhranhiV3FTVmVxOWxuVldRSUt5MGdRd2RLRU5SOHZkUmVmM1lv?=
 =?utf-8?B?eXlUQzVBL3NvZTV6NGJBeExjbktucUdmVUtPV2xBQXFFWEV6eXVSbnEreER0?=
 =?utf-8?B?Mmo2ZnZPeVhmVFh2M0NSamRYOEh5MnAyc0F1NXJsZHJQRGgzcEppaytRUGZ0?=
 =?utf-8?B?SWxKWHUwWnM4SHlsVlV3Si9CWnROcmhpcGdvQVB5bk9GdzFSZzZGL1dLaUlT?=
 =?utf-8?B?RGZ6bEovaU9qYVB0YWFPbFlkQnVCN3pPSEJod0lOZW1vbXdVekxZSkV3Y3Nw?=
 =?utf-8?B?T1BBWm9EbnMram4yR3hGSDg2NERIRmRGZEcrYklkWkIxKzdsa1lBYnp1Rmps?=
 =?utf-8?B?K3VhTDdGK3JDMmxxbDJlUEh6R1NjdlRtbFVlWEVvalpvay82UGpRdzF6Qk5T?=
 =?utf-8?B?V3pIZGpJcEhUQlhlNTZ2Um1oejRJbHVzOHpld2RyYzRHTFlBVlZHd2ZieHkx?=
 =?utf-8?B?cGYybm1IclRnUFNEQ3NzVC9JdktkTmdIU1QrYW9nMHFRcGtLL1pKellrc1Vy?=
 =?utf-8?B?bHN5M3dTdlZpMjlWQXdmYnRpZnl4WGpkV1lmU1NOTi9xNityVk4wNU45U0RQ?=
 =?utf-8?B?c0QyRzhDUmk2ZElkNzBKd1YrbTRuUFlPdzBSSjM4b0pzMEZXOTQ2YzlxWjQ5?=
 =?utf-8?B?SkNiRUNwZnVyZS9pVUtrZFZSc1ZGQWVsU3lLamxjSEZNVGxPbTNYMC9xaVRx?=
 =?utf-8?B?VTMyQXAwaUU2TC91MUhrS3NFYjFHZGJQZnNTUVZRa1dMMWhOdUc2dFBFaEla?=
 =?utf-8?B?aXBqZDFEV043R1hRK3VNM2ZhREN2WlFBRjd1RGpZZE9keXZpOHhWZ3VhZkVl?=
 =?utf-8?B?QVJwWXkxbnhvSnZrY2k1UE9GaHZaV1FBcHQ2Nk91Q2VkcnBxRTN4UXlnYzJH?=
 =?utf-8?B?LyszK0RLS3ZHSVIwVmlSTXpIODVZeHFmaHZ1bU01WGhMWjlUeVFCR2hnZThy?=
 =?utf-8?B?TGJISXJVYkNaVDh2NWEwcHFRNGQ5dGI5R0VZYzdVTUltVWVTNFhNQ094ZmM1?=
 =?utf-8?B?TTJHcklWTmRoYm52djN3UkV5WFVSUXdvbGRXcy9uUjFUZHUzOHZmeTZpVDh0?=
 =?utf-8?B?eStNMHJIL0pJOWgzbmxXb3Z6MW1SN1dBamN4Q2VkU1hMaGo5RitWQU5MK1RT?=
 =?utf-8?B?UlRidEZHMXluenBTalVQT3NIbTIrR0xFU3ZPMVJ5M01JSlNVVXlUTURaUElP?=
 =?utf-8?B?dHJab0psM3EzN3ZmMWJTdTFVcHovYVc0VGRIRzBBdEVIa0dqZDMxd29LaTYy?=
 =?utf-8?B?Yys2K3d0RkFHNisrWmdYcklVMEpWODVFY1ZYVjhVOXBwbGVNZFVtdlVUdStt?=
 =?utf-8?B?b0ZEcWN0cVF0cGNUZ1pjRnRXaXBUalIzNFJyc0g3LzlIbVUxbHV2bTdobm1o?=
 =?utf-8?B?OVZaNExiVWpiREMyT0lPMXFFYStVN0lsRmRCK2g4bWJUZG1Uam43aVFCWVZ5?=
 =?utf-8?B?TENNLzFzMUpRTFlDZDZyUnUrY1RiTVd5RHFMZ3hyQlBKeUszc2ZIcTlMUlRG?=
 =?utf-8?B?NFo4eEp1eHZ1Qjd1L2lYZkNYWWdZbC80dWVEWCtNMU9iakhtZ0tZMVk5dzFD?=
 =?utf-8?B?b2NlRUZLWkdVY1cydmFxYW5BTFdLRXVNS2R0S2lDUUR1a0c0dGhQNVFtUUlK?=
 =?utf-8?B?dFVMYVpLaWYyUThpUExTeW9PYXhXTm5XQS9PdjU0Z3VOMWFGREpBNHdWYVFz?=
 =?utf-8?B?QVFJZUpZWUhUR2VRbzNLQzA0dVNMN0RqdHVGYVZSOXZDd2E5dHpUa2VWMnlE?=
 =?utf-8?Q?2T1bwUvOZV2PIoOxd+kYbY1n0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0f1d3b-b466-4459-4620-08dc4f52f13d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 18:14:43.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qll/iFWVg+v+B8e6Lz4hAY3pDzuUD+L+vEVdVPKZdq0x4fV+NVPgF3GzhVetotqgXsZFT8iZSnlQ7o4YkpJ+dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8697
X-OriginatorOrg: intel.com

On 3/28/2024 11:04 AM, Avadhut Naik wrote:

>  - Since only caps of words which are not acronyms have been changed in
>    this version and the word "REVISION" has been removed i.e. changes are
>    very minor, have retained the the below tags received for previous
>    versions:
>     Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

> Avadhut Naik (2):
>   tracing: Include PPIN in mce_record tracepoint
>   tracing: Include Microcode Revision in mce_record tracepoint


The patches look good to me.

