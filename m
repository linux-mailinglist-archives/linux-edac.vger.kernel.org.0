Return-Path: <linux-edac+bounces-3017-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31573A3041F
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 08:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85C01643EC
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 07:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365651DFE3A;
	Tue, 11 Feb 2025 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcJLcOLZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A0B26BDB6;
	Tue, 11 Feb 2025 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739257436; cv=fail; b=lmMchZ/dZeuZumK4+CYLR7wr36XDGjx6k+5WiAZwPplxf7PNkc980W/il3JfFlUKSzVncTxoxyUKpFn4Pr9k4dTfqSHqjLlWAgQP1Ch2fu6vD2Tj0bNvadT3RUVcd99xMWAgFs9GC7mfit9XN2ZFaMPrGQVbCNcd274EOQ+vNb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739257436; c=relaxed/simple;
	bh=WC7y9gq4TK1r+j9CoPh1m5NnXYFXkosQ1zVoS1YPC0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j9h5hfq9o9dYxiF7V75jY0/XtCQN/VrE/9GPLSVIwUM4FbwBKIIcJrcSimagtrp10dScZ9eImxO04yyXoU+Gx5QVZO/NjYBQD6McinrNC7QS5yAeUkO/96Y6QCzC9LSqnY/aX4/E+m6oIuCwUlwvdYzGHfeB36zMktWOObswki4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcJLcOLZ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739257432; x=1770793432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WC7y9gq4TK1r+j9CoPh1m5NnXYFXkosQ1zVoS1YPC0g=;
  b=gcJLcOLZxH5/D1aFfmvw6t1+rwXwXsTFXYqIpNWr9dJRmpbw5jv3G692
   ko0h1x131q1OT7X0yVDYeYjq6JZIogPM7RIXAuDKV1JTmDyHZg1O7ePxw
   0sIvw9AnlGHQp2dIJB0s6Ssfn0tQJpe3sEbX5AXYxeHzXsAzCaU4iemgd
   AVYEGpwRHvsy5QHv5ScfF3UsyUQ2dbtQZqD37MSsqT7Wlg4zBcWQakhTL
   MCL4z4277vLuX91+aoUNEyCAKriatFkNE2FKP2bgKd8M7UD0VHUhl8uhC
   fVTIhi0g9liVnok04piZU628RUIhjK4lQn+aRNpfh9t1iK8hELa/Ua8B9
   Q==;
X-CSE-ConnectionGUID: pJusOO41TzyUHzRZnzGcqg==
X-CSE-MsgGUID: AvZz20d2SLaiAlO/H6eKpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39558519"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="39558519"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 23:03:51 -0800
X-CSE-ConnectionGUID: dK86PctiSfezt6XjP6ICjg==
X-CSE-MsgGUID: oZNR50AKSOigs5jCpdaJKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="113060224"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 23:03:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 23:03:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 23:03:49 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 23:03:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pn+z2H2DJ2EFM8nZrn7RbuMRrBDKhe3uQnbos7qgoAG1cTWh+fyXtEPKawdArYnn3unekXfZndDQvNoUNCmKefXbT9dBmO4N4jMxV+WjOcOPHG07VjXWT0PxKlgQdov0jd1p6lcFLFR1znQYkofLu8meoEL2AEWqQ+zhnt/P8G/zSrizPDvS1wmBETtvZCMUfu7F4gc6fhD0Apoe3IM2R5UerxeGp2Irtk+txYeH1bOgbR4sV8uq6N395lDuv0l+Bh/x3pufzK22f8ZcEQnXeg4Y33zgCfB0G5JYoiZ170Y561rArQYub+zEMgzt6s1lElR0L/8wC+ZHpLmKewuCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC8KJ6GGxDp8ZoRvYRr2DoQv43RZ0XqNmZb7jPyg6ts=;
 b=v6Js8xgzLWj8mpG1xoj7TZeqNJwQWaAlm26D61vhNMQFlLesrkbB8XL+HC2kwR0QaxDdtJdfM7dCa3yX31FntAsQruTEMwdFtEivmgjI/ZHzoFsReAAwGCZx+Od6pE+MeCm1ZIg/D3BtM52ls4nE+fBua+wevU4U+o44q0gI7X5tiH+QI9MVqmDnHw0HVaQfNAjbe4XfcNnSKCbV6MTTq044rReSegctYBJOI5xXbWu8DTDObsQR8ZyWQ8cG2E7e8h01sEdA01jnrwNccld+ohDb44a4b+F0QWs7Zb+yftl9B1+40ZZaK7oiuWGYSecC/oAO2FOVFpRuJjhZO/Mqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CY5PR11MB6461.namprd11.prod.outlook.com (2603:10b6:930:33::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 07:03:47 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 07:03:47 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v2 1/3] x86/mce/inject: Remove call to mce_notify_irq()
Thread-Topic: [PATCH v2 1/3] x86/mce/inject: Remove call to mce_notify_irq()
Thread-Index: AQHbe9MmPOK3qhQALkCLeoLYg5EdtrNBrQ7w
Date: Tue, 11 Feb 2025 07:03:47 +0000
Message-ID: <CY8PR11MB713403A5AC3B0699B56A552F89FD2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250210154707.114219-1-nik.borisov@suse.com>
 <20250210154707.114219-2-nik.borisov@suse.com>
In-Reply-To: <20250210154707.114219-2-nik.borisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CY5PR11MB6461:EE_
x-ms-office365-filtering-correlation-id: ace905a9-579b-4b31-bb0c-08dd4a6a3b10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3lE3R6Aq7uEp58PW4p+per4mX6v13bv0VIVc6pYSU8GHYOnXLR7J8G5bnwrn?=
 =?us-ascii?Q?Eif8ctJtMX5ktNf6PCVgBErTPHf504MKnAWs5YCYM+CniH0tFnbwMD2wZQhO?=
 =?us-ascii?Q?9yv6zlwSdfPGn+vGpQc7awmIjvCkJoWs59tqnihCsUzZWKZo5BmjG9Skp+dK?=
 =?us-ascii?Q?lGDhPb4C3iuYfSmMoqMzIwYK1E8+yUJezC4+yoHi3NufpOuCn+tTSIhvjzG6?=
 =?us-ascii?Q?biZ+d9fyWZRNHKjOQELxnrjxu/hwe6Q/Yp7RyUVlSMHg6sDqx9O/dc1A1lOe?=
 =?us-ascii?Q?ff5FxePXlK0vQ9OzsDBGuooa9ZqRX8c4v+Y7L6cHozdNlfAQ9bI0zjbRa2TN?=
 =?us-ascii?Q?iKq5Ototnk1Y8SQbpf8ETGz9c8oq38vyZ50YuN/FSxBCZf0X74uuT8FkK/Ve?=
 =?us-ascii?Q?W3jn//R1I1TFenBD/X74PNEu6k61+CXM0Zk8DjJKvHFDE0q3oB+1RALw90E4?=
 =?us-ascii?Q?M66ddlkuGM91g78WfZ/vAmPObslObRnobkqxqJ6+brYvChNZyNEAGF77t43u?=
 =?us-ascii?Q?4lKQIu5NoUgW4Ze18IrWzfE9nxsFuIpRPmVYQtWtLBVAKdaczO5iJsBTmWQB?=
 =?us-ascii?Q?TNdVNvV5nB7zxsMFpsn+Gv0iPGQdWqsOx27sg7znv+hyWPkGAXDodgH91fw5?=
 =?us-ascii?Q?jgpGkNF8dFN3ow3qrtfg1/cLbPpAAoemfketH9Kcb+qikWCfF9iq/d3ClhLk?=
 =?us-ascii?Q?qgo5a09qjmdhFzFEzpC1hIlTi5vXdYDaPPHngroj0yKjlodvGfqTxmM3iwSw?=
 =?us-ascii?Q?mtLeISRCnNDPx4tBtP7BX0BRd1kwJTa+tYAWSB+Tkwh+crqZp/tTUxEFck0H?=
 =?us-ascii?Q?9zvWss5/PkSklIg2f3Jov9JEb1htYTGK2PFANzunM2ngkp6thp39JGOdQr9W?=
 =?us-ascii?Q?/BBJGEEP42IhwhA3FXQ+pneSPsQPug6wSBHxbtbb3YKedts6hJKQuTdmOLvF?=
 =?us-ascii?Q?e0BCuwq8R/9JAd9XZ9SChylh9qREhcWHYbywhbZagCfVjIOMvVSiKKNfGeKD?=
 =?us-ascii?Q?1flVM6643ro2tv/5qvC2soXHBYGfYRxIXXp8iLhCafkDj6QcdV+zQzYS8SUc?=
 =?us-ascii?Q?l+/R9sndwYrDUDffne3q573HEpo6OsOq5l+1j5mtzv4RcJPWaObubnvfmpAx?=
 =?us-ascii?Q?I/dOUnegMT78iC3Otwb9CKyY26xMSIgE0ULNhRnCoQOSIXL9E+7yrM4dSCxG?=
 =?us-ascii?Q?6Wkn90i/UvaduismgbyjCaPFxqE91RAol64eVvSSzbmITa5Za7hqlyma24L3?=
 =?us-ascii?Q?TybY2M9jAbcz9h/woKTrZKc+87DuS3lykTCAUP/+pNqRaZQHhVDRAYDu0rc4?=
 =?us-ascii?Q?+jFJ+g91JQwcx9Y1L1W/EKnzEKy1VrQpr3vENwEA3nV3NVPDV9f3ct6SsGd4?=
 =?us-ascii?Q?1NdhfjVnEWq6BsjkqIpib9/oOrvUHNHWtpFqoa36AUZRY3A2H4vhYVKNrST8?=
 =?us-ascii?Q?x+T6Ojcw4ioJV0l4J+p4A+jaBGHU+NfA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+6LuKi10O3eS+/8titWxieyOa8hni0JLjStdnKYGfIrN7KI+ChekBJd2zSJT?=
 =?us-ascii?Q?9HcK5BDikBbvyO22S/E108r9ON8/bjP+NE2x1y3Zcjhtlg9bb1E+IQWKyeYX?=
 =?us-ascii?Q?AOykMu1PmPM7n2w25z7P70AKHh6aPeT2z4cUrZWLWcVXwpIZaOnyRrd7u/29?=
 =?us-ascii?Q?AcvM9N4fesVRxNvpsV1cRWPT+jizWxvk3KBBUvBTMXPUpcKPR4cphpQF/k8Q?=
 =?us-ascii?Q?iZHUhpqDNLfI8wUvIjGocSDnlcb5Ylt8fMIt6zMwSNEJ9xDcZD2aEC8ZfPpm?=
 =?us-ascii?Q?egFpBslslFJikEifmom0rZ3bvgNuD3wjmmR13ft572ztLu1URehdlhTvUejn?=
 =?us-ascii?Q?uSzl7zBFWFhuDkwn7KoZtmN0hRNCrDxct0gPP0bRogbZlYmRrVIV7phJ8EqN?=
 =?us-ascii?Q?hhc+f+6ypsSnztGC1aOUqbQlbN2dwgxb7mOr03ENpwgBmZyr5/w6bikSdMhB?=
 =?us-ascii?Q?7Sr4Vy9vqq7iMbxnCBZGniWLKFFMBpkG4doXB/4gysZDCid+QJOn2TlAVvjI?=
 =?us-ascii?Q?JFuJ/fDyJIvI2pL2aQz01G8ILok4byD7xB8Go/n3YmZS2crYW0nrc2C7wt+H?=
 =?us-ascii?Q?CSzjrmNzNtYh6AV8Z2VYkmujZsgSJ/t0U18r4GfjzmVLoeOd92M3HQXZfu96?=
 =?us-ascii?Q?NjwjDzRg1kGWXjbsm3F1U9yDzgGyn9dEmd/Es8BgfZBPfp0F36dfAkj991qL?=
 =?us-ascii?Q?kvkaJjft0k6raL6mKgmUXPOKERSg6/oIzeLMrILYgj6gdv5PFbMrVj+C6hyl?=
 =?us-ascii?Q?xweQI/lpwm181agy/9qqH3XjeJCmaWCmkplEbW6QC6YfKYNnCMnrE3hroiTf?=
 =?us-ascii?Q?ovJk89osBslc8qjUQGwLvFp3PGqomGu8Bbln8C5Ohki7ek/3FpgQo3JCXbeM?=
 =?us-ascii?Q?n28BjLO/2jV/u1Al3BLdIoK4PPQRt/7PDd9X+ya2htialHAxQgT2jsy9G+rl?=
 =?us-ascii?Q?ys1MN/g/sRx1edHCCY3DJjQpCC+kmo/GpPDnc+/HFmc3zmnlRhbDgmA/tgY4?=
 =?us-ascii?Q?nBDwD18f/oX8aMtgl5ije/lliGMFZLU0pw5nTwhaxqw1zH8eZ06e5V4qNngD?=
 =?us-ascii?Q?prar4iZlKDn7xkej2n8CjtHjdeOWaYY9g/VEW3fZXWR3fIvy8Ki42YwsnYJ9?=
 =?us-ascii?Q?+zlaPIBPfgfFJt2X2uN6lwatZ4U42oyeso0v2aQ3NWdaZIfBXMtD4DqrhP7+?=
 =?us-ascii?Q?nDEOR0lRqbP1obhsqcLH29h2rY9itk7fsvqYEHjAVtwUYTNLwNkCHmEkMSvl?=
 =?us-ascii?Q?jmHENvxquR3jS8NH08suc1KaWHZPpirnBEjmaApeCLaIJDp45MnQ+vrNp9ut?=
 =?us-ascii?Q?W4FmU8EqHKGqW/55v8LibRsb9OGIcsd6rewBwZ6ZviN8h4c2/mPXniYs+SLN?=
 =?us-ascii?Q?V3nDWAZw3BiZqO7HOQpKLfNKSebu+FWi1mlDrBRay7r84D21MuAZ7ERK8gOM?=
 =?us-ascii?Q?mtNW3fQY2vClD2h3zXPTOzPXohXbhS7w57zNb3F8hCeA/CeEdJUWFB4ZS+d8?=
 =?us-ascii?Q?DWaiwMY8U11yNH8GrUdCO52gvcMGkaNLvucm+093tWVrgU6jlfty43yHDxUy?=
 =?us-ascii?Q?HGdYD8eTSpcRPw9sCeGHMukOZlQB2NeFdqGMWEK+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace905a9-579b-4b31-bb0c-08dd4a6a3b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 07:03:47.3834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prm57Mr6kKNNWtsjhLLzLRUdevbL4E3k3qkl6v+eEJRvsZCq8R4DnGk+M07PBN2dvAgMcCYAeTdHzd4o/L+aEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6461
X-OriginatorOrg: intel.com

> From: Nikolay Borisov <nik.borisov@suse.com>
> [...]
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -584,6 +584,28 @@ bool mce_is_correctable(struct mce *m)  }
> EXPORT_SYMBOL_GPL(mce_is_correctable);
>=20
> +/*
> + * Notify the user(s) about new machine check events.
> + * Can be called from interrupt context, but not from machine check/NMI
> + * context.
> + */
> +static int mce_notify_irq(void)

Why make mce_notify_irq() return an int?

> [...]
> -/*
> - * Notify the user(s) about new machine check events.
> - * Can be called from interrupt context, but not from machine check/NMI
> - * context.
> - */
> -bool mce_notify_irq(void)
> [...]

