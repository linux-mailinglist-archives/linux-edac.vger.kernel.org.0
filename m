Return-Path: <linux-edac+bounces-2012-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA4699ADCC
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 22:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B8D28AB05
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 20:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9F81D12FE;
	Fri, 11 Oct 2024 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8cjtNOr"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D32199231;
	Fri, 11 Oct 2024 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680140; cv=fail; b=Yo+Wsh/M2Y7XTGCBHAjSfBcKxYwGzEYvmylyDF/aqy8MGIjKYDWG3dNeQy4puEy1mBDByQ0NVSnpk0xE4lH2d9B2riZ5/m5Eta0KLuL/gNAlnIzT1YZ7Yg9ozphVBbbiNApnMPDd4+JIzkLFSItLgwwLJvlz8/3jR7zMmIjPKr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680140; c=relaxed/simple;
	bh=SS+6PW/tpszAZLCwBrfAbJ63PRSFmiUj7QmyiUj76Yg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKhKLxaISbVPIeuVHKpFaXqO3vtFziDpU6UgLkCQ5Gzqve4kj6mb6eGrTPKNZQkqHN0GJT4U9W77u1EU6F2OHznPRNq3MJkvTSrPGxypL5ZaT241coYfKR9s12sVOp0vFGDDoQCxQLAp+eK6so3xdcAkWwKRdgsOK7h9NYntnKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8cjtNOr; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728680139; x=1760216139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SS+6PW/tpszAZLCwBrfAbJ63PRSFmiUj7QmyiUj76Yg=;
  b=F8cjtNOrG0qkAEBcUnSpq+znzBBwp1KAjcMWgFDtRCveBIyl2JqgbqxO
   Yzri5ofziHa9nnXQ39hFJMh4GqO6ccYbS/HKxYYFgr3VIVeKw040pijGa
   qY6N8rVEg40fgHxdyQyPTA8n06rQfzQ6mkK3c+Yd8tb2JGzY6mIY3aZth
   lrBYQFwg0PMWI9+srYZ29riP0jPp1ssj4ndNrC4W+vh5iR9Sjfa7YSWDU
   VZJJByzmDVONkuyQlQHReaP9tZfeEkvtzobxtkPCHQaYUj3Q8u89sq1M4
   9CqZDhmkjc8/Pnb/yYlG8gSfndLsW1eGRxYpLPWK+wyyKI8jyGRVLKbiV
   Q==;
X-CSE-ConnectionGUID: kLGTbHdOQXey8A2wAjyreg==
X-CSE-MsgGUID: CtxgRWKIRRqmCbWmp+8Scw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45601143"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="45601143"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 13:55:38 -0700
X-CSE-ConnectionGUID: qRWMMW6AQce1jtC5P5CkLg==
X-CSE-MsgGUID: /s7zMTaHQs2Q/3WR7KW4QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81828004"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 13:55:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 13:55:37 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 13:55:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 13:55:37 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 13:55:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTpv3MbZc0AQyubY4PgAB/ji8puamG0YQrUKsfaOAiKyh62Fz6u0SV/CU4BD2j/YNl7PTfkTItftACTaAn3ojOwmyV6qh3m12wUcqO13ejS2pSQCrSehwqpWejiyo+jdj8grI4vKBZ8vUsiyf3zt/6KDQYsqkOw7hCZnve+2qzFXAjrB+OL3kZEHR+K6oAjXqYOfBtrxPnETQVyicTgs/XZIkKKtxaBBZfVuFJyaX2ejpBHzsvXhzeP01Ji1TP4rKkM+CueFFnsWK5UrzzmXGT5wM4meCbgcb+XGvR5eILwqPmch184XI1IE2nEvtMGCPZxvzcROf8ApRxG4/6uZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS+6PW/tpszAZLCwBrfAbJ63PRSFmiUj7QmyiUj76Yg=;
 b=BKjP9j0Wag3V8clc6KD5IQjqbGxwzYf+w1mtZNgygx6eq2XZXQHgp7IyXy1a1Pi6+wMqjvpzqK7NS65bAdzf6h/U7hvXR3Pr2hpi/RRVw32DW0/1qoldjPqjUmykirkh3n2ERKCIdcx1seeYGZ0x9tstn9BpU+DbMXPCjarkGE74wsLTF+0AHs72AI1XsIqbwbkGYx+o6OZVSzl7GsIqTsNBaSVsH3kOWDgA42TyNGqrLXCHS8pVNY35NrMctNrC+KSsvyngKQdRCNQwWl2+EJPUW0ruSCrmCN7s14COuZguiEObn9UtjL50CCuaow8N4YVW2TlDmsBr3oCuyTcx4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4703.namprd11.prod.outlook.com (2603:10b6:806:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 20:55:34 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 20:55:34 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 09/10] x86/mce/amd: Remove unnecessary NULL pointer
 initializations
Thread-Topic: [PATCH 09/10] x86/mce/amd: Remove unnecessary NULL pointer
 initializations
Thread-Index: AQHbGyz3pxLqp5VKJU+sZjZc1ZAem7KCCPhQ
Date: Fri, 11 Oct 2024 20:55:34 +0000
Message-ID: <SJ1PR11MB60831B366C83422057E0A10FFC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241010153202.30876-10-qiuxu.zhuo@intel.com>
In-Reply-To: <20241010153202.30876-10-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4703:EE_
x-ms-office365-filtering-correlation-id: f7948888-234a-453d-dab8-08dcea370d16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9wctHMFzVoVmC45tpdry0KSCrjZL3UzXmrzHaDpUWuept/smvxPZzkRoYqGB?=
 =?us-ascii?Q?c49FMSQKpHH78/9L7AgCqR0bd7opHEsaNLtQJqVX5iwuvWu2+76PTVNRSzck?=
 =?us-ascii?Q?Uv7NiYp56SjNHHfUDi31gSThBYOln9/R/8pUhF9tjkDnCr3PWm+BOO666maA?=
 =?us-ascii?Q?TlS6m2cAFtlh+F+plJc7zdCe9p7I5s/8CJnr9lTE0gmfujy+QKUmSPi0vv8P?=
 =?us-ascii?Q?LrP0l6on1viheQwgp5URAsXgG+aYnGZBVxn6Ya5bkl4dhlnUhUjzBMBIyZdN?=
 =?us-ascii?Q?4inqeiPnPBIb055I6XyZOFu1DOr3WJTpSSfhsWWP8Zscb+F2nJQ2GSs23+nf?=
 =?us-ascii?Q?MvJAqHK3t2qFdPXdIZXT+tNZlt8Yx1Zfn8Bj2TN2GrHOTqtCo5xxtgzDKsHE?=
 =?us-ascii?Q?zJcKtTC2E2QcAdsLr7Y6wvqtB+00HiL/L/H1T1swDrrnOsUmFVrOxSZEGiRr?=
 =?us-ascii?Q?E2Jcg/D4jqG1zN6LHXD6aS8Ckt/ZrkyTsfWTsFy6AOsaifxrLvnZFcsZUu1/?=
 =?us-ascii?Q?Qqo897RscgylURabNG168XhP3POUiSqQBUkC65gn8HIAT3FYcFqXrMH2uc7p?=
 =?us-ascii?Q?nCCyqqOUyp31hLQS7bkKZpIuE0pV6Ko5ED8WY9zbqFzp+rRC/culvo4vP2/E?=
 =?us-ascii?Q?5L2tdmrVajAmtJraonyDQ+hQnvBiHvhgJgT64n5rIv/O9RpRqAlZ9YkXKNTS?=
 =?us-ascii?Q?4f1Qu6OIBbzkOKSZ/ji34YbF40u6cGjTo3QasMFxMXevXHM3MYvqQUpXYF/E?=
 =?us-ascii?Q?gsp3GJGyKH0cz56u0RJe4dCbj7WqwjBc0E1otRWEjIB2cWd4NtXdBDtaHWB3?=
 =?us-ascii?Q?mWtzqJLOLV8cij5VcMvliP546aUlQrtloSyFZssiIgeBRb4k6pI+OBFxDJy3?=
 =?us-ascii?Q?PFnbAzh1Oy9Gf9FwWqY1j40cNNYVwITWqoORwCxBEuyV6bbcD2aWkucz5Yj+?=
 =?us-ascii?Q?Y2mQxj5HwsEtQWLePkv0hZnhdM+3ZZZxA0PfPwIKZI3LN8qos38w3dnlgLZw?=
 =?us-ascii?Q?jQTdv2xVuuVl2Ozmn7OHOH75t2i6fyIwGUU+SATaTjFnMl0o2vyI8p61BJHP?=
 =?us-ascii?Q?NbQHdCPD7mIamY5wPFkwRrSWETyoCVFv+9r9RrZuLFxZSoTyiBh11qnJklME?=
 =?us-ascii?Q?mVPNcYC4J1Th13XvWY2ZkmQH2x8CN5i/CMv7knD4qnKuKm5zsFeXsqKh35nK?=
 =?us-ascii?Q?AqNueMXvvai9Ukz3gSSgTYM28+9StJOGVf0mOnWGMRu3sWDOBAHUl3og0hmL?=
 =?us-ascii?Q?7oJlZ/AxAcDWaMIKSrIdsGvZ/KD2RdpyFysdeHiJWFzKYbKA/0Qwte0u38wM?=
 =?us-ascii?Q?9jHxmmpT03jFT6OBq/mO/sZltlzBgw3hCtQ9do2on0XYZQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F6Ub2SVnVcCUbLUnRJorEHCdNEKTkumlTtjpAngvmHzJeCNw5JKa2+luZeTM?=
 =?us-ascii?Q?JNCXtIynzFQ9xfmCKahZN19A+Ov+J658HVWp0CC6fBgNveqwjDWZdHfcL0mT?=
 =?us-ascii?Q?eKZD4witUO9Zxk8bGRKmN0fVIvtpcsLLslqSpZciKvkG863DKitd/TqNTuOQ?=
 =?us-ascii?Q?d+PBvIggiwBCDrEJ2DrcevFd6nSuGH7N4jBTbNSQ5sLjb3OA3ZQROI3jFV5m?=
 =?us-ascii?Q?VoDum4OR77mFOVT+mGU/lSXciZUdh1dfpUNO+/tYh1MylAwOVM9Wm7QyQEC9?=
 =?us-ascii?Q?FvGXkcZSfnUmhaz2AUGbtqefiw/vlr/xI4PVAgXBsGkB7avTVAIQHV596nY0?=
 =?us-ascii?Q?37xGY9hRMpCFxdGpt5BmRMgg8/Ben9iPtKLC2Kz+N/JAacHHAiDLEXbGkigU?=
 =?us-ascii?Q?zkr0g4WmmK6XV2Q0KwRRMUezbn6XKCOABwsW0fmtry9Y65eaDid3FWyAsDCU?=
 =?us-ascii?Q?01RnpwfZ8hwlb9Q2i5SptCvP0jDNax/2rfSCIHui93ufYjmwDZbTnj3piJLw?=
 =?us-ascii?Q?Aoohxo84xjyQdFeMksawXB48Xwwf9UBz5QhW0qKOu4YLV3Z38xYc66JaULSF?=
 =?us-ascii?Q?7clM+H8tsBwYBw5JROBq4YQG6dILk+r3yPOrlCW1hd18ZBny3kCGssyOJ01e?=
 =?us-ascii?Q?xs4oxneSyCCe3L7D5OScS/UKEFx6J0ozDDvrKXDPBXWfBTjBBrUDJf6FIBar?=
 =?us-ascii?Q?8t9axf9RgD6s9TJKF3vRiWMDlxUGLThYLJUO2GXBDg3nWLnQmE22blavcVm7?=
 =?us-ascii?Q?va9oPAYqgQRT86mD5jgdQQSndnTXBxp+ikeh4FieIk1Xal0RdI5+eIPH5P9W?=
 =?us-ascii?Q?LtyNy1QP8H6r4G18enK1ovR5UwCkOXuvpEn1fAoZLM8vDg+GNPGlGhzrh+jS?=
 =?us-ascii?Q?d9DLhccQhNPlSEvNr3SRC1dwu/hsC7FsoaQSyek43K2EZCvDrQqnvEDfSWc7?=
 =?us-ascii?Q?4922se1QZZhSZ4Jl4sS0lQkxUiGRgndIOsVuHur3+V82NV3RFoXcbfQ81+RW?=
 =?us-ascii?Q?Oq/WLtyK/7xtpi3lRSNj8Ryx1B3nmvYRYxeArBcfKzc1BBMOUBC13RJInqPb?=
 =?us-ascii?Q?gENsFl0/nT1dQuQzT63hOmXY4XxsaO6EFAZLm5NWRRe65bKFkwqzyJ1moP1Y?=
 =?us-ascii?Q?R3g8nA0oNv9xiCJ+vClogb/WoOUjEpUDGPWOAEK/c0p4r8dU5AM19RnKcw2c?=
 =?us-ascii?Q?ysD862uKONRtmgaofp60lfipKviZ72QnxHi9HWwx4nZiIo8Ups8PqyWM7EWF?=
 =?us-ascii?Q?QVI+F5xvlRyLIi2fgUN7gM7RE2BYlt+WEBvK2Ppbb2LKppJyy9LyGRz1VCqY?=
 =?us-ascii?Q?PKp+NmmSUfLF8JBXhw2BcufdVJwIf6CErf6zkx9b2VoYGysqVFe91SHRsAwf?=
 =?us-ascii?Q?x611EXox3CTMuCG46HCg7dBZQhDMFVLfeB2nqrxlO2bw2k21eItchx1oeHPW?=
 =?us-ascii?Q?pYO9TW0wDKrAOKFKYC8oCCIYzXWwxbMYfn1jGCtJerZkeWtclek6BEPjcwfD?=
 =?us-ascii?Q?nU4Fy+Nrnm6lg2TGv0690LLSl8QXLAjlOnc3JNTY2zi6ZRI8zlJMB5EYVGP9?=
 =?us-ascii?Q?oenl4AOEIVuIhLNkO/kg60ODSx1o8aJ9Q1i5B8CA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7948888-234a-453d-dab8-08dcea370d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 20:55:34.3260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ihd86sVL/rIYtpPmD2Puic53jp6x3t9NElArp8lcyMGWiEQ8UwRFIdpJKEvkuT3dJ0nn9WuvTOY5qQrS20A5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4703
X-OriginatorOrg: intel.com

> As 'pos' and 'tmp' are initialized prior to their use in
> list_for_each_entry_safe(), remove the unnecessary NULL pointer
> initializations.

Nit: Comment left out first_block and block which patch also fixes.

-Tony

