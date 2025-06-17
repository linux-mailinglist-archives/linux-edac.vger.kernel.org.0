Return-Path: <linux-edac+bounces-4157-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF632ADD62F
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 18:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200C43B723D
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2EC285051;
	Tue, 17 Jun 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xpx3I6cT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8AE285045;
	Tue, 17 Jun 2025 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177010; cv=fail; b=EcQtq+1xNyxko0gNTexIni48kb8zJGA9pnEl0VvhaE709h4k7gQ7BDHal4mISuargtLKb9Sz7bEj5HBU5nw/W71nUX+cDLrD9AO1OI/DnGxPQNHqAB3vI60BjwfYUnZvqQ83IzvMLTHxKPIRjGFrGrAYf4hkGMwENSEMHzRrAt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177010; c=relaxed/simple;
	bh=oCRvULwHY4+ZcJnBbI7vGZhT+bXZQNmMzscwx/0G1Qg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qmbvTGrbrjDaMUvk4oFuhWICQDo8JJwdSal3JQDAB49oQuJ9bvSKllXioTxqPMaFnK+bIqSCHLNJxo5upL4/tMOcj7UsHgZ+/Lc2WmZG6rgZyy/x7qqKCRNqKZbBK8MfwoOsrK15bBVXEkJQYQQGxs3HeUubyPUTykiK/tqQRk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xpx3I6cT; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750177009; x=1781713009;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oCRvULwHY4+ZcJnBbI7vGZhT+bXZQNmMzscwx/0G1Qg=;
  b=Xpx3I6cTRP3gr/tK+BlRXomixTuotB6gI+8LBMx0UcguYKbmWQtYP40+
   V8FUxyRVjV2MeqvgyWqInfnVgRzrBouQ3kfuNRFl/rOwwlGoLF1sGC3Xz
   mQHKk2/RGGyOZm/WUpDFlXR3RpVk0F/YUMseHIEajTS91P4sg6lfcCcJP
   /Wv7vzDahxMI2Bs4g+mfdAMdtKu5dqpwwlP7DYXNJT/JlQlanHFLgCjYU
   e40uhDN9NL3n3tXzJsu9mValX7XtrmcJnRJCU+Y6kDGoSei8wstsSOw3Y
   WnUyyA5m0pnk7J2BmRDxbPqw8ybK8gIjPXEdyf/2czSKMMfQEfGY9/PYk
   g==;
X-CSE-ConnectionGUID: 1Ik2f1joTyWkyJMWQOo5fg==
X-CSE-MsgGUID: 0OiVP6PsTcW207PnHpX9tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="54984094"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="54984094"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 09:16:47 -0700
X-CSE-ConnectionGUID: Rpn0qMY5Tp2jGjvO1LffKw==
X-CSE-MsgGUID: ci1iLDTvQBefx54b6GY+KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="148742029"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 09:16:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 09:16:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 09:16:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 09:16:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hx5/aU4/O2wQFJ1uanEbP9DNOm/iXWyFJj1rrfcWDs3utey9HUUGcGD5vhogp3twm/MaFiOcJD+dpAlM+GvnnYBqPvyY9+zlX7dnUtBHlBuvk+q7CbWJcMNU0KIIOuRE+H6LzEWYz9Tmmq3TH9i0EqaeJokhniYS+AXC2MH5w/n08KojTyTiIETIEu3AJNCqDeBesBTkPCJ2VMu1VRc90J8+UWJi9S+0bGUuOA46EMTsoTsjwPXZ60jZB8jINxpB4b6m9scd0O+O00VpUA3/l13+PShUD9jU7Miyi0bAKDBA3fpVWjGZ7iBdpfxrPqBnTcvOkNRFZk3FikqViEMyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCRvULwHY4+ZcJnBbI7vGZhT+bXZQNmMzscwx/0G1Qg=;
 b=f3DRBxQgoFgpeTKdmxe7pEqSrVBy6Ep748yt69xcjIJusRXyYOhzr+/hWRWDQewvCJknVWAjyRO5byyj0dF69linSaec0eCZSjydZwUq4BCY5Z4ywTbyh8fRwkXC2MIvDOzJr9vgDuqoprhdzlAdJy4/jMdEb7oTKcWNgBomPmJ3YM2MCbkvRl+98gw5qIGdkRiCdayn+arCmU2ZGopl5pBU1JNAjTrYBELn70mtvQT6dKFKOeSyHuhJ1frc/BS2n+u1HWc0+fy8m9fbIpNloYlx8YzWadTv4WTWkpxKLFO/nti+aPnU8wJ3p47wyqV+Fd0QptWI4ssGLlgXxjwHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB5960.namprd11.prod.outlook.com (2603:10b6:510:1e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 17 Jun
 2025 16:16:41 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8835.018; Tue, 17 Jun 2025
 16:16:41 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Luck, Tony" <tony.luck@intel.com>,
	=?utf-8?B?TWFyZWsgTWFyY3p5a293c2tpLUfDs3JlY2tp?=
	<marmarek@invisiblethingslab.com>, "open list:EDAC-IGEN6"
	<linux-edac@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: NULL pointer dereference in igen6_probe - 6.16-rc2
Thread-Topic: NULL pointer dereference in igen6_probe - 6.16-rc2
Thread-Index: AQHb33j0iZ1WW20c2U63eSjoy98u17QHPvOAgAAUdvCAABxbAIAACzdw
Date: Tue, 17 Jun 2025 16:16:41 +0000
Message-ID: <CY8PR11MB7134444B84D6860AFF1C85078973A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <aFFN7RlXkaK_loQb@mail-itl>
 <20250617115707.GBaFFYE61vYHNuAkxR@fat_crate.local>
 <CY8PR11MB71345FDE3DF74BAF97B563F08973A@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20250617145150.GCaFGBBvUvkrtpO9j_@fat_crate.local>
In-Reply-To: <20250617145150.GCaFGBBvUvkrtpO9j_@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB5960:EE_
x-ms-office365-filtering-correlation-id: e5b6975e-08d2-4841-fa9e-08ddadba5831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?alV3QUxGWnhHT1NwdnNWMUxMRzg2cnFTb2Y4THJtMUprRlNaR0FTRGppUGY1?=
 =?utf-8?B?ZVVBQnloM2JkN2laZlFCQjRLMHZyR1gxM1JWVE9Zb0w4VVlhQXU5SjY4U2Yx?=
 =?utf-8?B?dDYwYXR3K0VPbGx4WFhnWG54ejlUcGQ3MFJMeHBQTkxCVCtzZE1wc0FaWDJ2?=
 =?utf-8?B?cDR2SnF6OGhJQVY4amRqTmhqRytjS004aVpTNE5DWkpSb0RYeEgxanFuaWsz?=
 =?utf-8?B?YTVaNzE5MVlRdTJtU2xlUkxQTUErcnIrRmszb3JxOGNUd2Y4aHZqQ2UvZTBU?=
 =?utf-8?B?SWVDREtDTisvNEo3dkpxbTZpNGNqSEJ2d0RtOW9WMlNjbml2aUZhaEtxclVz?=
 =?utf-8?B?TGhMZkJEaUppRGx3Yk1BdWhDcjVPTVNQOHNnYlFYT1p2Q1BkY2ZqUXptUm1z?=
 =?utf-8?B?b2VzV1RTQVFobVE2NjljRDk4NlRobXlpRDliSkJsTTd0Y1N1aHBzeXdSQUdo?=
 =?utf-8?B?QlNOa2cyUUkyd3hVemdLWG1HZWFIY3hMb2MrZkV6OFgrTkkvdGVRTHdQWjRv?=
 =?utf-8?B?VmJOVnZoNUIxZnI3Z21ROUcxMFY5SWc0b1R1TzEwWWhOd1p6cUhpZG40czJS?=
 =?utf-8?B?SVlHa0lpLzAxWW9hYUpDMm1DWlBDR0VPd3Nqajh4R2gvQlhndHhZREl1bG4r?=
 =?utf-8?B?bUY5NEYvZHRGbWFRY0ZlaXYzUDQ1eFFJc3hwZ2pETHd5M0Q1M0FtNkxhS3Zm?=
 =?utf-8?B?TTM4VWZ6SlZWR20veVhkRHd0cUY0eDlwbXIyL25NbllKRkhNOHZhS0dzbTlt?=
 =?utf-8?B?WXNFTlJYSkFHUmxwSG1zM2lMbkxEbktHaUxXRWJ1cWUwelZoUWo3ZEpubDBp?=
 =?utf-8?B?WVFyUnRFbWowNFFXc2UxYXhKVHF6UDJDZ2JFcTcrQVJOTVJZQlpFdXJ2VlFr?=
 =?utf-8?B?OFBrWVJtalk4TWVyYTdXVWNtMlBTalhvc0MwZWJhbHlyZ0tSTTBDeHhySldK?=
 =?utf-8?B?WDZqTFlob3ZyZ1FvYVFVUElkR3J0Uk9pOW9sTHR1eFdTV3JqdEdWT0tMUU90?=
 =?utf-8?B?aGRjZkVPanJWeDhpM1BDUklpU3ZNV2Z5a1c0UEMwUjMwYU83cUlFZVdLaGE1?=
 =?utf-8?B?dERrMis5Wmpnb3BHWERTYmtOWmFrUjNFRWI5OWVFV2tNQ0I4Nzd2Sm1RbkNN?=
 =?utf-8?B?ckhXdjJDNkVGdW82MFdCRXM5NVBidi9vd1JaMUg0bStBZWFLS2hsTTBIbDJR?=
 =?utf-8?B?VGpOUzR1a1FhVFd2NFFySlJ4Z0RUSDFOeE1sY2kxWjZGdnhYdERwa2wvR3FC?=
 =?utf-8?B?RVFXT3V6QTJkcnIxVTgvR2xtekNKNVl5VW5CR3Z4aEpVdUxDQjEzanlhRERG?=
 =?utf-8?B?SkYrRjh1WTRPSllkRUl5c2w0Mjl5bHBhNjhwejNodmxMeW9ZTE5QM2RBWVNY?=
 =?utf-8?B?d0RUUkZIY1B3OVRsVHVlRmtlL0lGcEo3VE41eG56LythNjZ1bHJreS90Q1k5?=
 =?utf-8?B?amVlOCtyN1RveXBHV3BmQ1JsaEFRN3g5czdYMTdZdDBnWmVCYUJZMk9LNGRP?=
 =?utf-8?B?azU1NERIMmxjVHY3ZXFhMEoxL09pMm9iSkN3Q2hIQ0dnUGQvUlV2d0EvQlNG?=
 =?utf-8?B?aHkzcEF1cVF1M1phOVBEMlI4bzVkNjY2eTEzYnlGcXlra1VCRUhqTTlSRklY?=
 =?utf-8?B?UU1OUXpzZlY3M0c3Sit5Zjk3cy9MWlg5NWthWnk1UHBzcm9QOGhWODlvblMy?=
 =?utf-8?B?TzdnY3JaczM4RkVIUkxNYnBtUitrWlpUU3Vmb04zR2ZCdTBXU2VVQXYyRFpu?=
 =?utf-8?B?NEJGQzIvdWVVeTFXYTZ3aGxsRVRZanM3dGxwYmdsWXVFaHlaaVZueDRsRTlj?=
 =?utf-8?B?cUduMlAySW5tYWQ2VTJjVDQrbW9BZmhuR2xkZkJWa1NCdE9zUUxQTVZSWUwz?=
 =?utf-8?B?ait1UXhsaStGMnJUZytwYXRLQ1EyNFlJZnIvVHdKYXRsM2lkNnFNcjFCTFls?=
 =?utf-8?Q?lNtxWCodkEA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnJ2cG5zZDBKT1F4MEUzUGcwWXBHQlZZOHJVK1RzcDVzZUFkT2RGSnpHdFkv?=
 =?utf-8?B?VjZMbWlCZUZ2OStTRjZ1WVNwQjdhWFRyMkt2SjJCejE2THFBU1h4UnJXVEJO?=
 =?utf-8?B?cWlLRHlPbUM2TGFRWXlsS3F6TGlnL2tUcnQ3TzFLUkNuZUtkbXJROXFKVC9M?=
 =?utf-8?B?dG1FS2Q2bXVnQ3c3N2srR2RpQmZ5ekx0aU5HMWxqS2tDKzZHYS9qRVROWS9h?=
 =?utf-8?B?ZE9xcjRZT3oyZmlVSnE3dDBiaklTUFNJeDdMRS9ndEVEdHA5Zy9jOW9iUWpC?=
 =?utf-8?B?ZllQbVljVTM0UkE4S1FYbXU0ZkMwZFMyN0ZVZDZmOUJqak1XaVhsNHd5dmRn?=
 =?utf-8?B?RzFqT0lCSFNyOGwzUXhMYXJFYmV5S2xWbDRXYXhjQjFUTnlTSlJpRWljRWpM?=
 =?utf-8?B?SUJLQnhTRkhDajN5Tzd4Qmhna1JnQUYraEpzUXJBZkVPaHFIeXF1amNucCtk?=
 =?utf-8?B?dXBKV3RiSHBIQlJ5V2Y5REJ3SFlyU1U1TW9MeFNDMHozbmVFWm40eDNKaW42?=
 =?utf-8?B?ekhManh4anlDRWFLa2lJNnd1TWM1M2UvZ2pyZWo2RkozNTI3ZDQwNmhYZzdh?=
 =?utf-8?B?Wkw5dEVRakdnMHBpVkppaW1zTjhnSGoxTVg5SHpJOXh0ZUtPU1IrSkR1ZjBJ?=
 =?utf-8?B?Skl6c2RwZ1VwaCtTcGNCenR5alR4eS9qYUthdVRjaXNKd0cvTEdqWURkVERv?=
 =?utf-8?B?Q2p0ejNoYk8va1puUEVwMk1vMFU4eWJkdWx0NEwyUUNZUUlncXNKSGhJN1ln?=
 =?utf-8?B?Y0pKYlM0d3J0KzJXWmM5SnFTTklzanZIRWphWUlrVm9ob2JaQ0xnMVNTVTJP?=
 =?utf-8?B?U3l5UHgvSjJVMXVSRy8zUTVSbUVBb3FzakxJS1h3VjVvRG9aTUQ4L25rUG92?=
 =?utf-8?B?S3BmbVQ3VmJscHJEaVRqdUljRXM4NlpHUTRTMGNMb1VlQkNpak5BbGpCTVJS?=
 =?utf-8?B?NWxmRTloM2ZUb1RncmNUKyttWHVROE5ybVB0U2dxNnBYNWptMmZZTXpkUFJh?=
 =?utf-8?B?T3FqSVNDSXhHb01QZjF6c0ZqZ292STJXcCtHMUhubUcwNjNXOE5iRHBGWlh4?=
 =?utf-8?B?VG5EQXgwQTJCT3NjS2UwcmN0eUxkNzlidFJhV2ZEOUFnTE5aYkRWSmhVWWlw?=
 =?utf-8?B?NFJ2NXZmUUQ2dEZiUGZLRjU1YVpwbGRrTmRORDJmUXgzVEhtTmxSaHB2OEVr?=
 =?utf-8?B?OWpISVBPREx2NEQvSlpFRU8wMjk5cU8xWFdBTXFoQVZ4N2lsc2lPR245bC9t?=
 =?utf-8?B?OVIxQ1VHWFVwQWsxSEk5Tm1adzdDbmFjeFJ2U2cwbTlQK2Y5VjZXTkhRd2ZV?=
 =?utf-8?B?TzcvQjIxRjBKZ0xoN0lienQzUFVUaGxBWHcvTFBIOVlMb3h3RHBqazNVbWU4?=
 =?utf-8?B?NUtRRU5pdThzYVAwUUVhTGhrRzg3alZtVnhGYnIvUjdOT0ZOSWo2cUxRTFI1?=
 =?utf-8?B?OFJzZE03VDJ5REkvK2M5QzRzQnEyZnNjRjQ1TDVtb1dtQUdKRk83aWh0NTd6?=
 =?utf-8?B?SGNNeGtSRlI1ajlzN3YyQVN3UlZJZ1V4RUZkaHlGcndXVmlPNllPK1ZkOUoy?=
 =?utf-8?B?UWJERHAyYi9qYS92N2VDajg1N2x0U1dyekJBcnB5eUVIT0ZnY1JhTVpRdzBq?=
 =?utf-8?B?TVdSdGlzenJydzBQV2lKUVlZZURRbXNNbG93OWlYOFd5cUZZcS8wRjNOampW?=
 =?utf-8?B?VDMzRHd6VlFINVd1UXd0bDhYREFORGYzTzFzeXNGMzM3cENhaTZGR1VwR2xp?=
 =?utf-8?B?amJSeHlyL0h6TjZQSlJ6aFkvTnVBZW9ZZUhmb3pLNmpRK09xb2JnQWt1OVNp?=
 =?utf-8?B?V2hwT1R6NG9vZ3l2VkwrTjB6V3Y1aHpMclZLYVhBSVVJaW9xT09NQU9tbERQ?=
 =?utf-8?B?TlR1a3E1Si9nWTdzeUxtRklMMTZ2dUJrS1VXTk5BV25ZM3ZrYTgrZm9SRDlU?=
 =?utf-8?B?ZkpZOXhQZFg1OXE0YXpXRytxdWI3UUh6TnZjZXJFS05xa0hmUGNZZGFtcHpE?=
 =?utf-8?B?RGc0eXptdTNXRThyQStDQTlpbEhqSml6Q0NiOWZxYk1Vc3oxSlBFZ3M3Z2xh?=
 =?utf-8?B?OTIvVExsYVEvV2svNmNTcFl6cHkxYmtyaFVURzMrY0VaMHRzdFU4eDQ4L0h5?=
 =?utf-8?Q?83O/5pedUjgDHThU0awYeKjka?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b6975e-08d2-4841-fa9e-08ddadba5831
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 16:16:41.1297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1AQTiyE6Xxl6MBXKsE6RyStryeqK3Y4tZxPyFJBro0KH3G1iUCUjZ/PrnWfIwnPRwgIHwZxuX3h9vHQi8FIpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5960
X-OriginatorOrg: intel.com

PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gWy4uLl0NCj4gPiBSZXZl
cnRpbmcgJ2NmZycgaW4gdGhpcyBpZ2VuNl9lZGFjIGRyaXZlciB0byBub24tY29uc3QsIGFsbG93
aW5nIGl0IHRvDQo+ID4gYmUgc2V0IHdpdGggdGhlIGFjdHVhbCBudW1iZXIgb2YgZGV0ZWN0ZWQg
bWVtb3J5IGNvbnRyb2xsZXJzIHNlZW1zDQo+IHJlYXNvbmFibGUuDQo+IA0KPiBRdWVzdGlvbiBp
czogaXMgdGhhdCBzb21ldGhpbmcgdGhlIGRyaXZlciBzaG91bGQgYWxsb3c/IERldGVjdGluZyBt
b3JlDQoNCkluIHRoZSBpZ2VuNl9lZGFjIGRyaXZlciwgd2hlbiBub3RpZmllZCBvZiB0aGUgbWVt
b3J5IGVycm9ycywgaXQgY2hlY2tzIGFsbCANCnRoZSBtZW1vcnkgY29udHJvbGxlcnMgc3BlY2lm
aWVkIGJ5ICdjZmctPm51bV9pbWMnIHRvIGlkZW50aWZ5IHRoZSBzb3VyY2UgDQpvZiB0aGUgZXJy
b3IuIA0KDQpFaXRoZXIgY2hlY2tpbmcgaWYgaW1jLT53aW5kb3cgPT0gTlVMTCAoaW5kaWNhdGlu
ZyBudWxsIE1NSU8gZm9yIGFic2VudCANCm1lbW9yeSBjb250cm9sbGVycykgYmVmb3JlIGVhY2gg
dXNhZ2UgcG9pbnQsIG9yIHVwZGF0aW5nICdjZmctPm51bV9pbWMnIHRvDQpyZWZsZWN0IHRoZSBy
ZWFsIHByZXNlbnQgbWVtb3J5IGNvbnRyb2xsZXJzIHNob3VsZCBmaXggdGhlIGlzc3VlLiAgVGhl
IGxhdHRlcg0Kb25lIGlzIHNpbXBsZXIuDQoNCj4gbWVtb3J5IGNvbnRyb2xsZXJzIGJ1dCBlbmFi
bGluZyBsZXNzLiBIb3cgY2FuIHRoYXQgZXZlbiBoYXBwZW4/DQo+IA0KDQpUaGUgbWF4aW11bSBu
dW1iZXIgb2YgZGV0ZWN0ZWQgbWVtb3J5IGNvbnRyb2xsZXJzIGlzIGJvdW5kZWQNCmJ5IHRoZSBt
YWNybyBOVU1fSU1DIFsxXS4gVGhpcyB2YWx1ZSBpcyB3aGF0IHdlIGtub3cgYXPCoHRoZSBtYXhp
bXVtIA0KcG9zc2libGUgdmFsdWUgbm93Lg0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZh
bGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvZWRhYy9pZ2VuNl9lZGFjLmMjTDEzMjQNCg0K
PiA+IEFmdGVyIHRoYXQgdGhlbiBhcHBseWluZyBCb3JpcycgZml4IGFib3ZlIGlzIHRoZSBzaW1w
bGVzdCB3YXkgdG8NCj4gPiByZXNvbHZlIHRoZSBpc3N1ZS4g8J+Yig0KPiANCj4gUmlnaHQsIGp1
c3QgcHJlcGFyZSBhIHByb3BlciBwYXRjaCwgcGxlYXNlLCBzbyB0aGF0IE1hcmVrIGNhbiB0ZXN0
IGFuZCBjb25maXJtLg0KPiANCg0KT0suIA0KSSdsbCBtYWtlIGEgcGF0Y2ggZm9yIE1hcmVrIHRv
IHRlc3QgZmlyc3QuIA0KVGhhbmtzIEJvcmlzLg0KDQotIFFpdXh1DQo=

