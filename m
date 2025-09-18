Return-Path: <linux-edac+bounces-4638-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 783F2B30AEB
	for <lists+linux-edac@lfdr.de>; Fri, 22 Aug 2025 03:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26EB71C846E3
	for <lists+linux-edac@lfdr.de>; Fri, 22 Aug 2025 01:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE589143C69;
	Fri, 22 Aug 2025 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cr8rWY3b"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C42CA9;
	Fri, 22 Aug 2025 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827139; cv=fail; b=ll6fY9K5kQUfTKT4jY7E1rjCvKFeyYTp/ZeiBHAVWgo9nG+O6oPXt6YLZ4ngl5L+pwF+71xIFZj7nWSySmZI87/cwRQf6NvlMD7lRKNtAvcsyO7+9+Jl31cV5V3rPbvgc/VKDIbjyOHQEmQyZsdgPs2+X2ko6FKAq5cqU23Jh6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827139; c=relaxed/simple;
	bh=uP4bhaWG9kvOWrayozNeJLMfdkhoI58O6EMmREdneZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qGJJfb+4mEThF9XHV316iq4Hf+u/8flGxieLg2y/E6XYP9EWsYHd8t51sDBcG+U+tCnUdUq7SlOHRLQTrKirPIIGwKwb1w1EQIKn7oXPUdr5wcqNBJ4tkjAaqLNgtNKDLSQcxbdvooAj6VwCaBD13QgWyL9YbGjtD3wQahHziN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cr8rWY3b; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755827138; x=1787363138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uP4bhaWG9kvOWrayozNeJLMfdkhoI58O6EMmREdneZI=;
  b=Cr8rWY3bvbfe72EtF/vaIxU54taUIYu8U083sH0rgAcwLjLdC+xjL39D
   o6K3kdqLHXtL5kt8GuTER64fXWz/ixk4rgx/ZCtqyqcTw2GKYUqUORC5e
   sc51jSmB03Qr63nZNTHXHCAvIMJ9YJp2RH9Q9BaUtlKC8QTmNV3hDoXey
   VoqI14HWKFkeDCMtxoXWB3Q6y0AsxgZ8gw/p8q0eBweWgWgDsE99yBQDp
   m75I/JQZ/yUSBdhBh3p6iyGh8NqIj3g/k/Iz6HtCdVkPIRNsnCZ3mQjco
   VKs6WUq6tStpRbswtvpCOEEpeppWbXWbh8iekSmgJeGjVtVqfJI9GFCto
   g==;
X-CSE-ConnectionGUID: pSFfJClQQ3u2uwwjNN4ldw==
X-CSE-MsgGUID: 8wRpiVXnQEO98KHslh/XVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68730497"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68730497"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 18:45:37 -0700
X-CSE-ConnectionGUID: yH+bqe6jQJG6fDn8PuUyRg==
X-CSE-MsgGUID: 801ZyDOnTCOABgUq3+F13Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="192232055"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 18:45:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 18:45:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 18:45:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.52)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 18:45:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbYHkERft7R6axg4UYgCLwI4uwEuiwpa/jPbWp+bNcGH7bwdF+tGdr90oxYxX2cGtayX16/ahsyJN/igSXcAAgPCQxpIFWq59OcK/lgUISuNUVwHWkeyQ8a1IG3PXTYhxo6lx6xthvjE7OvpQbQg+ZMVxdIQ4py5nwakdmduPDxYox4J77ZDaSYwiBgdIspTgJRA3DqGJ/KyB6ezSBTMJz/tnx0qR3/OOk7oE1qVZH2a6ko3/6hIZw7aneuicfH1lMWDt4tesGSsI8iarO47r5B2ejbxGp+Pm/trDvUO3u0Bq3icl7l7yW5J2lL6NAnAn37tFQ+QUwWemtLq9l7g3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP4bhaWG9kvOWrayozNeJLMfdkhoI58O6EMmREdneZI=;
 b=fiR5df3dK867VBNDt1S0ILr1dDed/YY+eY0X9rfITnBFb9UAyKuMnyzsabhg3mqWgCy2IbWNqMY27tBy3CnS1JRfAVpRZYcY7JjVU9JRC1IZ4GTlNFwdpJXKuIIrBp1dKDNi3ZDWRN/a+U0g7JwSgWKHyjWRzCM61Nwnp0l/qPc4WdoBWaOyPhBZkmbXzMGxMvqOMxUrZPhJYSZQs3Iem7WfNWUo0mTkvoqFFM4Z5TnpK4oJIJlQbIMNQgAtRaGbM4vyz0cjBQCapjAf+yhge/LgHZllDaOBcpB7pNBR+0MOGEWqBrU+rIZUZIqH6fP5wpfbTbuKV0xLeGRUBJy+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA0PR11MB7356.namprd11.prod.outlook.com (2603:10b6:208:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 01:45:30 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 01:45:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Carlis, Matthew" <mattc@purestorage.com>
CC: "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "Preble, Adam C"
	<adam.c.preble@intel.com>, "Schofield, Alison" <alison.schofield@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"Peng, Chao P" <chao.p.peng@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "erwin.tsaur@intel.com"
	<erwin.tsaur@intel.com>, "Wanyan, Feiting" <feiting.wanyan@intel.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>, "Weiny, Ira"
	<ira.weiny@intel.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"mahesh@linux.ibm.com" <mahesh@linux.ibm.com>, "oohall@gmail.com"
	<oohall@gmail.com>, "qingshun.wang@linux.intel.com"
	<qingshun.wang@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"rrichter@amd.com" <rrichter@amd.com>, "Kuppuswamy, Sathyanarayanan"
	<sathyanarayanan.kuppuswamy@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "Wang, Yudong"
	<yudong.wang@intel.com>, "Saggi, Meeta" <msaggi@purestorage.com>,
	"sconnor@purestorage.com" <sconnor@purestorage.com>, "Karkare, Ashish"
	<ashishk@purestorage.com>, "rhan@purestorage.com" <rhan@purestorage.com>,
	"Rangi, Jasjeet" <jrangi@purestorage.com>, "Govindjee, Arjun"
	<agovindjee@purestorage.com>, "Amstadt, Bob" <bamstadt@purestorage.com>
Subject: RE: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
Thread-Topic: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
Thread-Index: AQHcErztfT80IygGUEKHNugx9d8DuLRt5WuQ
Date: Fri, 22 Aug 2025 01:45:30 +0000
Message-ID: <IA3PR11MB9136FCB8C778B0AE08BF8DB5923DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <SJ0PR11MB67441DAC71325558C8881EEF92A62@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20250821165829.3471-1-mattc@purestorage.com>
In-Reply-To: <20250821165829.3471-1-mattc@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA0PR11MB7356:EE_
x-ms-office365-filtering-correlation-id: c456487d-f4f6-4f8a-e82a-08dde11d93d8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KckxwSsm/VEXDsfl+00iQgU6X5V5wXgoWAahiHv+e48RJe+3TogRo5TDfBsZ?=
 =?us-ascii?Q?26Low+A7i+darGa0r9qrxZ6QupbOZzsy/waz2pXGm0vQsw7ZMM9e4tVykY4O?=
 =?us-ascii?Q?W/jDGgEfIEzqfXNNRdyZTEh/5A3xJBV6drHqWOc2ILfv3v0pyVSBOvrGb/QD?=
 =?us-ascii?Q?pC96gVumkNl6cL/CHH0hMjo143iUI75t0jdl4gqnKCmCY1peegSj9M6nJnot?=
 =?us-ascii?Q?Mwmk7tqQ2R1O6Tvwyz9IcVLbqpOOjSZrzf7i54b5xG6UrmQUjNqo4q7rwbSL?=
 =?us-ascii?Q?NA9FT8MwVLS7oXNLzrSjsPAOBK5fYJGZGgTbh7BDGS5kCAgpteBL/aMwRN9W?=
 =?us-ascii?Q?f8zCkPjB3RVcYRsZD+daINr0n540rGdpNutXBDtNNa6zdcdINyrXgag+GZe7?=
 =?us-ascii?Q?ebW90RZM1qD41VCAVXV4jhN2wPc729kBx/0RuzLPgow5dKFMVuegQ6cMUI+f?=
 =?us-ascii?Q?JMe5Nt7D1xtUDQU0qQk1ZoIHyZAKYfb/rIMzbcm9kBD9a3GO0sjA3DMpmJQ3?=
 =?us-ascii?Q?fqzoJjeTKEMdoTq9BbUa8O8Hpe2pUvh3eSl5x5XJozkr5pUng4lG/eJDb7rf?=
 =?us-ascii?Q?IZJR7//Gx7NhRrU32+2r0kD32+o2rn1vTIxv8v/g5iGyQayFT2goRNJhe0fg?=
 =?us-ascii?Q?bdcFg9eAyq/hWxYTAd2iqUDVfCHUVnFdDEfNJNXiMeVta1w+IxCu/ndQsWft?=
 =?us-ascii?Q?awDTRBDyjnIVWNqKCMmJCViysT5cHF+vwFbc/0VtztejGAK+RDbPwmsFLPeT?=
 =?us-ascii?Q?zc3oIMwnMC+2JNCfK1Qc7XK7HHeW/hZo5BpD5Nur/rECFadgd1/oOUw8f8FB?=
 =?us-ascii?Q?S1pFrff0MxZ9o/muIDeYpI6WQ4O6Vwqkwd66GTHhXfPV28yAQ3cUpeX5o3/l?=
 =?us-ascii?Q?i+Funzn42sUc2n40zNldJX8y2qvTmoV1bl1Rb0Om+AQ/Xt5EQV2mRc7To4fI?=
 =?us-ascii?Q?T2fpofJYYhTvzN9vSoNKQMCl8NtHutoIKKmM3Bfcn4sR6Tbx42FiKz40gyeP?=
 =?us-ascii?Q?Q5eqgzECNWb1f8xq8zFBjFUnpQO29Vsp8beIhoTH04g9OHOMsiYtc1/QwZBC?=
 =?us-ascii?Q?ey75h7JBN8Yy9477JU1DfKRv4WO3m6a4ugPUtjxs94HoJt5Tn44BqYOGm9yP?=
 =?us-ascii?Q?LYGTCDWpeyWll4eLlSKnEbbZ2Lunpn4dnVOZscaqy66gP55rsyZD8SewZvk3?=
 =?us-ascii?Q?70kfPOXQFXtRx07lR1c0ojT6hpNz7syDa2kpatV+hJZKirZ7ZKcxj9Cp6t0o?=
 =?us-ascii?Q?TdteUha2arDsjeuHT8xvIefyYCwlGLdgzwxt2IinHgpREhGKv3cDj45xcc1t?=
 =?us-ascii?Q?p/4tIhjJgkHsRM/YyezkO9sgyD7HVcEQ+h4C1AbUop33R/YcbKTFxCTOu4hY?=
 =?us-ascii?Q?76hRLBhGLhwPvxAdOBjZfAR+SSezTn8jQiwnhNJ+lIblgWMFc2Gr5xdQ42X/?=
 =?us-ascii?Q?djyM8jI/NiYuavxy2QBfFkNguTbSlR+v8OOXbwxnB5LtddUoiazYtg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TVLcd0bmJFoNPf2jWLTVTyHLVQ0Pg+7Gu7SS2WF/om18fhMvY+CgjFNJGtVS?=
 =?us-ascii?Q?PFb6b83stbJ9B4nB/05x4rh1nRLlte6SxWkxeS5drtzSVERq/8GRXVK3tXss?=
 =?us-ascii?Q?Jp6CfXP/TFY8nb2a6lvdepQpOu9X2EXWimf/Et8lUuYxWp6XRFC2qX33EZjR?=
 =?us-ascii?Q?z+qxtD1l0bD1e6nOD3m0fhTXXUzuVq52WurR20eCYjm9+kSlYTqyhNAJXeMD?=
 =?us-ascii?Q?dPiYoCwWjNjdwBhJKQTOcDT8e7jDTCntBdrkDaVHhjGMfnH68a9yymKw3k9m?=
 =?us-ascii?Q?d7S95Z3YxPhYvWf/H3SYLc5SCVEC6gGwNlR0dWrjtjp3mj59myvnZSS8evTr?=
 =?us-ascii?Q?sVMpItc9nugX/bvubc8j/2P8mpMat1g4tqLJPTbNcawbhamHpW8U5YWOrveP?=
 =?us-ascii?Q?lf2TUGLW1LJ8TugA4U0/PXjpshz6hDYeNCOakGX1pyFpHR5SpjRDeQ2YDnjU?=
 =?us-ascii?Q?1/QdMfC9PUbI0K9l7Ofl7cjK9wKeWc7QB3lpDMTSODpz/a9L1yliLCRWTDC/?=
 =?us-ascii?Q?kOOruGchF1dsopgiEzbskIDhEi8ljnqUNWydiQWxUq5MQSYl+lFUIHXuTUOT?=
 =?us-ascii?Q?+He5gAwRykdkPp0GGnXtVTxs7SBMrtkPwW+HWLsAK2UuvKdIxVzEhx2zk9TG?=
 =?us-ascii?Q?7S2OzOgXw1BP45RIDWOWbjKjYJ8jGIyL49YNHJk68R/qoCidZVCLHULMaOp5?=
 =?us-ascii?Q?mhMbS8aTb7Vega6ghSjSIvi+ec8PxPVwA2KM+ZPaSz1TsNUTzkUCILXz6iKg?=
 =?us-ascii?Q?8twNwr1Pl5NPowIpcHYpxKxCmWPVDGSL+f0wKQFExGSKXviSPO+9/8t1ur1m?=
 =?us-ascii?Q?sXpT2QOQrJVsRxPxAB9RvZg75OuhH7rgk/l/SCMcEH9hpvxZD1VlEw0lPpgV?=
 =?us-ascii?Q?l6bjTz2jGmFYz9CycADi55qZTbnfQB7SaOzV2cnxogk66O9pz0DtG3DiwnKi?=
 =?us-ascii?Q?H8JKuxBZxKVZ2r2I6TjXCdVB2LkvXUVwJIVjI3/Z81bJVAZcpZ0tzx5OgIJK?=
 =?us-ascii?Q?ycqm+++d0bPQeyiEgbHnk56Fh4addxGabJD5ifP2oYOIYzpZ2mTklWZdl3Zs?=
 =?us-ascii?Q?Va9RsrlqXWcQI3/in/ygqJzsmgSe2hA/cvbeew63UO8rW+Dslhebv9cDM2Ww?=
 =?us-ascii?Q?uy2ME3lRk8vCKRyvKDxQVB7IIVLiraHv4qYpeXqTBSnf7K3Fedq91OjVvluS?=
 =?us-ascii?Q?61m12dhJZ+NSY7pUTpeflLef/NzcmI5wmtLhky/97AWfH8/XWFRlu3GtxGiM?=
 =?us-ascii?Q?qHgTUntKQ65/TV0rNDcSWMout0nei34vxPKpvSysqCDzxDSqtgIzeNh17Cbs?=
 =?us-ascii?Q?9hDPofmkM3k7XFBdfxYPa5DV5NBnmFGuFvferK3Kc/pAEKYw8Biaz2GDT1Lz?=
 =?us-ascii?Q?zqrPkFOwjld+YOKuyIiijKgkpDACh96B61vMPywCLyyb2jblgnD2hzHfjNYR?=
 =?us-ascii?Q?/rZzKCdXizsbWKlhMnJLsdda/FQJcN3o2F+g3A8X6dI8aQU77IPVt015am3j?=
 =?us-ascii?Q?O59X1neCTFP4Vae2P75YQqTg+1sK4madIQwXCuVt8PNaA1sxu+BGQPx1hmn2?=
 =?us-ascii?Q?2p59h3DSk5A//K33KGGRH01zcu2kAPZq5BOzZoJe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c456487d-f4f6-4f8a-e82a-08dde11d93d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 01:45:30.6950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yaZH2i0SkFT01ieYNYygu0k6jbHYXwTzBePXvKbbwD+aknPDykWd7MwvB3Q7GsvhV7hKXh/k1mD5yrZ3LQY2zKsz0DQdQKuHBjG5gE8laNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7356
X-OriginatorOrg: intel.com

Hi Matthew,

Feel free to take it over if you are interested. Maintainer didn't respond =
to this series, perhaps he expects some improvement in the series.

Thanks
Zhenzhong

>-----Original Message-----
>From: Matthew W Carlis <mattc@purestorage.com>
>Subject: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
>
>Hello. My team had independently started to make a change similar to this
>before realizing that someone had already taken a stab at it. It is highly
>desirable in my mind to have an improved handling of Advisory Errors in
>the upstream kernel. Is there anything we can do to help move this effort
>along? Perhaps testing? We have a decent variety of system configurations =
&
>are able to inject various kinds of errors via special devices/commands et=
c.
>
>Thanks,
>-Matt

