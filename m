Return-Path: <linux-edac+bounces-3678-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E630A9952B
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 18:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EA6923C1A
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF9B280CD9;
	Wed, 23 Apr 2025 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+vq+66h"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8CF19E966
	for <linux-edac@vger.kernel.org>; Wed, 23 Apr 2025 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425610; cv=fail; b=b8TUSmsaXz9U2yPnTOsmAGYB82v12qwcgfhFiMQJ4q6U+Unw7kb8BOGljh7SoV2V91sv/YQNLPKAx6rSe2x1IQPI8E09lts79WWWUxZfxKk0+VFyGyCrbLH8RhI+8DgjivZxez6wRiXNK+BHTTrlQDRwMkkuHmdUYWMpbYLlPaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425610; c=relaxed/simple;
	bh=9uJ23Z9oSZMc4YzGG4E8D+sLmlTrZOFrhVHbxiD2/cQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PlaSrRhHglS/UwzkXx058KSNfmAXYfiWM5Ofu8K/TDiUcJe/gSi/GrinOxQP1XBkpgN3VPBNwabbg9W5KaVIhd/BPtgbEHSsBBPTcp7S02qkn2LpVszCfVTspzLNYYQ3DyZC5WwGZYJDzSo2EudvQtXtP1O/wSW9EqmhmwN7Rjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+vq+66h; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745425609; x=1776961609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9uJ23Z9oSZMc4YzGG4E8D+sLmlTrZOFrhVHbxiD2/cQ=;
  b=G+vq+66hl+PT1PKFWUv5vS8jdv645UkYq78e0ONzKwmcij/c0JOLXU1F
   hk25C6KryEZDMLFntv64/i5BVuTeQNKMga9VwVhUMa5pnqH2vQ+h4Hav1
   n0gNsFy7cuPD+sc5HG/3zesFJE4C7pqMaGUjJ+ZtDLiUdsv4HNm3m8A0/
   BFunpOZLgc5EJ6kh8hMIMcSfNvSpVpl99aK0JLG21hZR/DqKYxXBOWH0X
   tePxRp+QAt+RLw1z8saGP2De2/RSWrkAYNk3d3fw1SwakB/szK7M+wfAa
   j6HUJN40Wpfq7MK5Stojf5/nkNoxxPxolJDs24sRIRxIG/JoHxZaEgD0f
   w==;
X-CSE-ConnectionGUID: 0hS1pOtGSbmAgqOQZVTVGg==
X-CSE-MsgGUID: MSI0g1k+Sj2Nz82yv86FKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="58392690"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="58392690"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:26:38 -0700
X-CSE-ConnectionGUID: obw9qRHoTDOoTY47C1HjXw==
X-CSE-MsgGUID: kaPW+7nfQ6aD1FV76B/rpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163404057"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:26:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 09:26:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 09:26:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 09:26:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdMEsQpTb9J93DNhHoTCvTePVk/hfXMcILNW7u5rjdLWHSYKk3kMKmoxzeZAoFc+q9bp5gp0yDLLrVDB2gOj0hBaTqm1EUJCOrYQjt7/WGmHSxuOgpmmLjHzJouh/eNIO4mVFq9tvJjjMGOTDKyTZ/AqISKWFGKdVmvYCeEuXbSYsGez+V6weNHM7YGi0heUA1SMRsAj9z49iT2wap7KDhqO5c9wfnP6m5LHu0WLeQRCIEt5uNV2A9OJimLRXg2TH4Q3RxGMKeindRj17Cdj07AlYqYluFhwsvoPnzWug6JJznHqK5yyXfJiutTZdIY2lW1ck/XNLo2UJb8/F88yrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KR5M8/fLM6lg0Jz5yJcvdwtPEiLMMcOhLh/aTuNKYE4=;
 b=KJ4WXQbLn0g7v2Snw4RirxJaHLJ4MoVgKQxlj8jESvwOwRU7uTcAGn2bMD0u4dRSHk8vLKPN8CwJJSGNKk90BRa45ML6eRau0kFUaPfyX866gdK7GHPztAD5qhSn3LA9QhuOHda5Oo7NpMyrzpplQr9QWCiETwlIWQJ2nh+IJ01TrMXR0+LX4aYI/HkPJ5IBi0dsGopVb0iuDLW6bARj5kuO/ucRZ3UGhT3DjWaLzZsWfdpGmNmt6wpwV0v5tnlcXsHE3e4uwyzrNNkb4DQbMRTsvQ4qO9kWr5c4CT8VacYAFmgUKYHO3QPO9SveE3u8QNhLxbf9aOnuW2pzPRUDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 DS4PPFD24E991EC.namprd11.prod.outlook.com (2603:10b6:f:fc02::52) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 16:26:21 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec%6]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 16:26:21 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [bug report] EDAC/{skx_common,i10nm}: Refactor
 show_retry_rd_err_log()
Thread-Topic: [bug report] EDAC/{skx_common,i10nm}: Refactor
 show_retry_rd_err_log()
Thread-Index: AQHbtCgMrDCDe2ufx0quRowENIlKYbOxXheAgAASDLA=
Date: Wed, 23 Apr 2025 16:26:21 +0000
Message-ID: <DS7PR11MB6077471F9B1B3221DA9FDEE5FCBA2@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <aAih0KmEVq7ch6v2@stanley.mountain>
 <CY8PR11MB7134CE0CA414F81958EB5CEA89BA2@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB7134CE0CA414F81958EB5CEA89BA2@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|DS4PPFD24E991EC:EE_
x-ms-office365-filtering-correlation-id: 45f35491-465a-45ea-b89c-08dd82839577
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7xKYFBD4CQylBdSJbYA0KFawTgxY00NRyRpJQeq34c9AzO5/HXyvmZQDQV0h?=
 =?us-ascii?Q?IMdUuYdgeIRU8NeXYX1AXhra7P3bA+QOzn2RCyJf2wr2Yqkl6n3K6PpiLE7X?=
 =?us-ascii?Q?4tm/RSvt6FsnrXgTyrwPwa+HaZLGRv6mA8ttnRxkiS6M9lt0pcKh+nmyotui?=
 =?us-ascii?Q?rmKqqzrSN874zSAvipQfkhzzfpYUKiN9uN6GF5bLNjQSMILCfrjJwMUTnV5j?=
 =?us-ascii?Q?EgQmoxJOVjSQhGiEg8XmEUFwy8FeYusnWd9fXVPBeozNNXJsByhNg3AZci4O?=
 =?us-ascii?Q?CMEwdPDESMwIlSmjkj2X85wMQ6DaZe6NB3ABQLhjyNE68YHzkM+MUvkIjyyk?=
 =?us-ascii?Q?RHPqcvsqynvEtWArQluxPGxu0hVo6PO6yKrPn1hf97iTPGAxCMM+ATdZzdFz?=
 =?us-ascii?Q?oFoHs1RREWh7MEhBqe1Wq/pZrU8kZ0XJ8ysONwiUTMjdVqTL/ctNR6UbOXkH?=
 =?us-ascii?Q?fusAwqf9FLvt7qrZoFY47BR0qLEENdherz3sASFH2lZjPb+Pv1oXeTsaPiWW?=
 =?us-ascii?Q?6lQ/CSX1jDUV7AguPDVhiz1tACiYDVDMsO0+B6z0Pz7o9j/MhAyywvoLswhS?=
 =?us-ascii?Q?EEcc9mbtoPYLHi7NfZWjm5pyQajjJbHXDPl82r9eyRFiC9VgjJMJmrkhhJRi?=
 =?us-ascii?Q?Jl6y4N226WCQvle+28Vl/xHfdJ1l+GpzDPiy7Tnfv5nCDOZQS/emKici8MiQ?=
 =?us-ascii?Q?G4xK/1Hy0HohBMyHSK2wXWd62kXouJAVvbUh3NSZ23RULejml48VlXyouUbj?=
 =?us-ascii?Q?3WQTlAvQ/Xo7C09bMsn5mR9n1Swiz/GVzR3mIweKMvkJKarXA83w78DidiJ4?=
 =?us-ascii?Q?GA44WaGkb9gujyD+pCLMipTElyhFFxexxbkNB0X5wwz/ye8kh5t2k+x04pN6?=
 =?us-ascii?Q?wXzpBJQ61fJoPkysmQXB8tTWPT8pd+Zlq+mioFGqSPxW21UMEjFEcolA01Ww?=
 =?us-ascii?Q?Hrmig4gDFKREK9v5d8t/9cdfpty4fDIvSf2q73iU1vVKYPBOGmpQ+iyHbVLD?=
 =?us-ascii?Q?KJho6Eq2f4iXiATnvSxyAU6wN4lVbz1XOFaACp+p+Vo6GZcJH5wqHvdMbZA6?=
 =?us-ascii?Q?Y6+siAvrK2EFhLefQkQvdVN4ylwYUWvfI60j20crEc2Paf+iGnHcT4ATNoPw?=
 =?us-ascii?Q?OUPX98zgUTMxvgZIvM+WYgbc/E55vnJZMQ/Ufmlfl/dy4m7/O64Fx07f3i8t?=
 =?us-ascii?Q?KZ1gu5x76ubVTtlQWI9AYFHolfIZTDygr+98bNCWaXCHXq3jKdpx0oR9cWat?=
 =?us-ascii?Q?gRG5DTygi4mfQK9OdpYX4NrsrxU08v2Sz+vpgy7pSAxA6+wVtwSVDoFQA6DK?=
 =?us-ascii?Q?F3VpSOLEWQrOUZp3t5GllT1jWaFWCzTLpWz6CzEs6sA7for7tvBI3Wzz1N1n?=
 =?us-ascii?Q?XiXrFpa41wCowtZiO1MwnfRJc6wL4RwXhm8rHt7D0+xJmH6hWBRc8e+e4IKm?=
 =?us-ascii?Q?LK6dJCmdd+xTTCgJafCRtHVp1brxNC4pnjOFU+nwZLD9ao6jjovlN07j89yp?=
 =?us-ascii?Q?UTbMhqoheai7+ms=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tyd17U+j1mlEos8iW0cTf6x9JObroXxnZGQ9jihNOm8nsOaQVdespKsPiGPZ?=
 =?us-ascii?Q?Utz7opxUk8fYrJQthvh/rwnai9qgnpERwZTbHgCGoDZqSMGFds26uklrMwJD?=
 =?us-ascii?Q?hlAgHXp9khMWYk3TTenLYAqRATDN+U62AcXag3k6mltwpmPOXWjbTFPwl5TV?=
 =?us-ascii?Q?vc4LurBvRlmiKhDUxTM47fGvl1n4YpzUpcASXASbU7eCXs1zw9RXdYO2cC4y?=
 =?us-ascii?Q?D+Vz4J3FA0OsdfWgxq0ssqqBv0fJa9Tsh+tbBqQrmIQGQ4LUa6A+/DyNRhl1?=
 =?us-ascii?Q?JWljhZOBTXBUXVbwxnQjzKUo6tsYrgXtxEsF5ZM1HKE8hEZQ03Nc9wUNEztH?=
 =?us-ascii?Q?jTP85+jxJQn4KXtihkx/4HDb+2MY4clA8cB9PkWlSjTumnuXogeSPqbJWnIn?=
 =?us-ascii?Q?1Mv8Jml1juSJZBQljF74ctfFE9uqiRn/ug8sr+/N3rEkZUL+YFLLlp9QDUt1?=
 =?us-ascii?Q?X60NcAf6/xPdyj8scf/0Mo68YJfpqLlDDJnRxXC/n60wp1ueA5nt1VtqGhfW?=
 =?us-ascii?Q?9ff1P1VsqCGM353Ir1pT1YfJ5VB4sF9HbVzIKZviNkEqF2bRGyuLRwhRPTmA?=
 =?us-ascii?Q?3Gmm+OOAv5Z2HXnYPzo+HpkmCWXO1jGdjXTTUvIHvtKZYL+bbNLkQOAU6XMq?=
 =?us-ascii?Q?1P5WRV+vba3Ur9WYqxLAjnNEbqSJJ5NlBtCEuUFyVR7zNM6bpxWNMdBPG4FZ?=
 =?us-ascii?Q?3cG3BLmb6a1Zm7wa1Okwdqu4AG+vtAmLuJ08myp1/0hED0yXGVLuNUQUFCjh?=
 =?us-ascii?Q?hi48WEkPUfin/nnYF6XqgShV4+YsAAsH3FdGE61BTRBNcQOEJET4DrssnFCY?=
 =?us-ascii?Q?TEF336Wnju34pdtWjLKatkuKqVdMo3XdEMH5za80E81ZTERt903XyJv+/w5q?=
 =?us-ascii?Q?qEXGvbe2utTRaDmZ0jDMJ6eFdOZ7ofyPVb2WDAGApW1tc6vKJi/ZVRflbxTL?=
 =?us-ascii?Q?wXAoWqrdJEMk7EHmQ8WO6UqnoFSbWApZQVjXxP8M8cRPFWxfGFTNcRtIkdcC?=
 =?us-ascii?Q?YG8SyL6zfPQifj2IuQvdB4Ge10ZsT0NuXxM+26uCEH7qBRyg/ziygPkU8Umo?=
 =?us-ascii?Q?GMOxSX120E4RmqIjyEzRLjq9D1rSQqxESzjOP+9yGh9hcr2gwtLRvT6w07A5?=
 =?us-ascii?Q?iV9Gd9TlEAgkHwG5ps6NfMyFhPi+8N9FL/4BqyPxMK6xQYBPNHZa887hVK4X?=
 =?us-ascii?Q?sUzMcoMVbNqoRH/ate1hHWKh2h6+qC+RxsqzWRBt45XaKgTafW87iuHi2Tp8?=
 =?us-ascii?Q?4fXk5gVsWtMM1eWZkMYv5C9DwwQ5igg2+zqqdEuP/eQezN8twPYWnoais+kt?=
 =?us-ascii?Q?TdF3CS9P8aVlfk5Y6KbO+mK2Gq+885tMSa/a4Q2zLG9BOLFQQSC0CkQZrzNi?=
 =?us-ascii?Q?7bvi0ryaFHsh99LNy1SbiMEmYL7xYw/KVdrzAuCrUMfIRkADILxN+O7VCie6?=
 =?us-ascii?Q?aXa1ECkptPD6DsaSMiwyZGnIOWJq7PRivPYaEllBr1JBrma0hx8JS8FcGj47?=
 =?us-ascii?Q?sZmkfJ/rokv4/qkU5yGCRhhj7iyApDjcVOzTPq+MtGd3H3NB3egZjSWfxSa8?=
 =?us-ascii?Q?W19b8SmyZRi6/ca2s5Zz3TZ2r2NNJ9Nf639tHUJn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f35491-465a-45ea-b89c-08dd82839577
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 16:26:21.6009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUFId9XsC0Asx5aC9cjuCT7DX66lNZdcVqbd555AWi61GrGNczgJShLGXwrOgYSz8gAs4pF9DSraml4DuCi+3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD24E991EC
X-OriginatorOrg: intel.com

> >     362                         /* Clear RRL status if RRL in Linux con=
trol mode. */
> >     363                         if (retry_rd_err_log =3D=3D 2 && !j && =
(log & status_mask))
> > --> 364                                 write_imc_reg(imc, ch, offset, =
width, log &
> > ~status_mask);
> >
> > This will clear the high 32 bits of log.
>
> It's OK to clear the high 32 bits of 'log', as we only write the low 32 b=
its of 'log' to
> the 1st RRL register, which is a u32 type.
>
> To improve code sanity, it might be worthwhile to create a patch that cha=
nges
> 'status_mask' to a u64 type. @Luck, Tony, should I create a fix patch on =
top of the
> current patch series to fix this warning?

Qiuxu,

Yes. Write a patch for this and give a Reported-by: credit to Dan.

Thanks

-Tony

