Return-Path: <linux-edac+bounces-2408-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120659B9EDE
	for <lists+linux-edac@lfdr.de>; Sat,  2 Nov 2024 11:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B561F215C3
	for <lists+linux-edac@lfdr.de>; Sat,  2 Nov 2024 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA96115B543;
	Sat,  2 Nov 2024 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeG/SeTZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C045016;
	Sat,  2 Nov 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730543103; cv=fail; b=WllvX0O/II04/9Q5KtrSAcCzJX/6xwiGG42MXxQkQUZ1JqLx6hbNzwVuYCFbX3AGi8NJA9px1Yk57GvCmQajvKqGZ8Tca6xXMOrvs9gcZz/mcGTfmS9h3yakgb26+IxgY5P2SbH/72mqV9orZ5fHuIx8V7ZyzBK1bkWGIKFT2X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730543103; c=relaxed/simple;
	bh=W/hpv874816ZR2IG7QS8EHlXCrFoXQRlkBKIBdlTRvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A1ZpSnADaVdMK+qfdU5rbFp7gFYev25zVoaMCTxJ9E++uK13z0y9gZz7YlZVzXjci6UzzNBKKpQMrt65IJwbJr3flcNZSLlJiFoLc2YtEQoOOMDJclVOlt0QmQIQFCeKODJoGBJRn4mUX4B3j+dc8GeU42xopzocGxhw32tfK8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeG/SeTZ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730543102; x=1762079102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W/hpv874816ZR2IG7QS8EHlXCrFoXQRlkBKIBdlTRvk=;
  b=HeG/SeTZumqbZ2D8bgQDUIE9PRUxl79umqIYjILOW8kff9kjal9fOeYh
   RqHb2bk61TduriyqGC1boRXpAqBX7hbmRsVszkqtbZM6VH/A/Bbk9lQS+
   5Vq++R6HAu5c1I+RLB1E9Vqd3h372YMsKyO8cU3tBeL66j5LxIKnVHcpP
   QU93VTMqVJMxguc0BnqC97EKQEgj46mupeJcZGK8BIsmmS9kgL+cP0VcS
   NUpR51d9QHIvPZYo1O04i/YbthnonXg1wxdz9HHKXRE7zuA2VsjJItHXN
   Gtq6FMS1WL1b8ae2h2pxEkkv/uXEOkkPVpRB7p0knUALUISyd7tkRbagR
   g==;
X-CSE-ConnectionGUID: xiPN5jv2Sz60tEbxLt+BKA==
X-CSE-MsgGUID: n5vGCmPYSiSEWzSc7egdRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47751105"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47751105"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 03:25:02 -0700
X-CSE-ConnectionGUID: Na1gYR1/SI24oU/pSwBq3Q==
X-CSE-MsgGUID: 9ejfRT3tQa+8YSBPxzVYVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="113975585"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2024 03:25:01 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 2 Nov 2024 03:25:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 2 Nov 2024 03:25:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 2 Nov 2024 03:24:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg05D0dpe9n9QMiA241XnTEsOyXNpH4Q1uUTkVPFEtV2tY+C/VMsdQRBL+yEwUtlhByK3Teko/2mrpGmWx21nX2lPCoLbWpgHoFSg718E9zo4VgTPq1Uib+1v8kydJbCSJanHf0C76J41RxIpVedOyg5umcdEC8gHAz0g0ae6oSKmL97N7e66OhAWHkG4jNbw+ZDzMl4Gn+l+GDF9v8scKYTBD5hrDy1vSiZgQOHmC3kg2zA+6XSgl0fFUcQAPUXE1VMj5Wh4hPMpTTxLEe1cSVRaob/32dA+66TEv64CdNvL3nSPYLP/JvY4ZbaJSbEK5oPzIegT3ZYjMXIJpA3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Gs6Av2ltxNOHkRLVqo+5Gf5460eJPX+P/9+Gg4VhD4=;
 b=I5JUhPDHFm10tnN6q+DDkhD7jrt+qT5tANy0YG0eQ6eVtrdTgML3kq9ws5UxxgdShbPJTMD2/3I0i+wFRaqckuE6+TJoBOt+6FtoS8HbqZ0mwARJkuXHQjM3DrXWzHTY2YRRwiJFNzMgzjiHYI9lgEHgsEt7cmCfeakWn7WkSACLisUR6Vnw6Jfdji0e2FDuveo5IpGnqZ+5SjpJsfvDBILAi2iobt86dhAlGhlPlsy8BF8IdCIPScfSiUksPpQPJKRWQdBTzyV+IPWRSyJQoNBAGFMhklTQDhRu7aPbbU+pHHEQRgsDHa8O8ZXKZtB3fFag1H5BVzPsWESAJtDSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.37; Sat, 2 Nov
 2024 10:24:57 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8114.015; Sat, 2 Nov 2024
 10:24:56 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Orange Kao <orange@aiven.io>, "Luck, Tony" <tony.luck@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com"
	<james.morse@arm.com>, "orange@kaosy.org" <orange@kaosy.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>
Subject: RE: [PATCH 2/2] EDAC/igen6: Add polling support
Thread-Topic: [PATCH 2/2] EDAC/igen6: Add polling support
Thread-Index: AQHbLJ61jWNC5s2L/E2Sm9NCifED+7Kjufuw
Date: Sat, 2 Nov 2024 10:24:56 +0000
Message-ID: <CY8PR11MB713406F82AAA380B02AC8B2989572@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241101204211.414664-1-orange@aiven.io>
 <20241101204211.414664-3-orange@aiven.io>
In-Reply-To: <20241101204211.414664-3-orange@aiven.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CY8PR11MB7364:EE_
x-ms-office365-filtering-correlation-id: 8f96381d-9f82-41aa-8cee-08dcfb289918
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7eAdJRIWVHcHD2Vlu23rMlLSWeVf4vVgf6+ny71K5YGqcXtTPfu5VjVkp1P8?=
 =?us-ascii?Q?5coJ66TcHiE7+P8tEBDyTtwbBVfxspx6N3pFXSC1NrnsCcUyfN4mEioqXhG0?=
 =?us-ascii?Q?GpXsZvO4NRjyreb2bKzHzqpIqZYXuW/pxPLCV7bPErkjfhBhRypzL90X/gVA?=
 =?us-ascii?Q?NXTNaPcCtwkaEYmOtMIVya4wIXzAXvYnl1g45TCwHMlRl45PrQB/4mOB5FAh?=
 =?us-ascii?Q?i0lNrumRLVyINhEOVvwjrO7F0rS2EuvhFA/xBdGavxsFy1Ux8Aw4iFOyWOcV?=
 =?us-ascii?Q?Oe9H5CmvXYjLRfQBmO5ripNxKzg6IYbvM0/NY0jMveLDX0lSr+q5BIYfhE6D?=
 =?us-ascii?Q?+J9YGfZF+mJhWY2qMXMScRrGAelB33RK4g93aezNM08kNcvVeIOEDlSzjJrG?=
 =?us-ascii?Q?TDE+ht0cjwM/MMGZISvmt95B4niTeYyQHu6wN6xIWQadNKsQNPaJmZiJTBEz?=
 =?us-ascii?Q?pWb33rhDcPb3q+FyPDggRiXJ0GbjDu33tTpgbElJGsdEdwqG+EHmeSn8BtH1?=
 =?us-ascii?Q?pIKEf6gqZmeseSkESiisc2nGHX/wx9G0oIKmo9dps86eJmDPZrFLy6U4irBy?=
 =?us-ascii?Q?L9DcVK2V73ZHTzcostcF6mymfKCDI75YkPVDLVd4YR03EHGVqXq8qXtkKs/h?=
 =?us-ascii?Q?jvG5Ud6MdobqAIt8BUgDZ7xq2gCGUYx7xB09XeAzOOXRANJ5z2dh0ru3z03S?=
 =?us-ascii?Q?NVsBhqE9en6kD4k8PEm5AQDIM4GwPPoHD5g/XGTE+naCb50H6vq/k4f7Plu/?=
 =?us-ascii?Q?g1ZQ9S2qwfFRyYZVi9srSTmJa+d9efg5dzMDv3Sv4XcbfD1pw1xYNeR8r4Nq?=
 =?us-ascii?Q?zB5kS+r0kckDiQ0B6bwqN4YY8WQQtfpRd5T8AJ36P+rx2YBX1deN47ABFrbO?=
 =?us-ascii?Q?cJqxfqxVvVvstERSMLNKL0sJXwGEez2kBxoF7TGE3FHVlHIbMB2al4cwlaed?=
 =?us-ascii?Q?rR1lVvEVaKODmBUJkmrqGdxx6/8glEYtoY3+O7uBqDIwcJzUeIcEl2a6LdMD?=
 =?us-ascii?Q?PGEThbeWaDE0iTjyL9SQpRsHJCEdM7KQXJ8rxxBv3nDTyOOuu4i8GYCr5Gc7?=
 =?us-ascii?Q?hQZLl+w0MI0rZNI0ZJRlUk0PXxSQf0fgH29roADDJv0ego+9gAa/pmUti/uX?=
 =?us-ascii?Q?2kDZqqa6dYi0Jsl4y9w0kwrwt7rnAOcTVP5pmznBxpyIkGukQrgow70xSg6M?=
 =?us-ascii?Q?p2SNq1tR0ek/rTLUvJ4qzSxdqToXis95RkHeK9KvLK2wxARQkgAafeKFN4CT?=
 =?us-ascii?Q?lo3t9exKzskArIgMeb/HnlhW3pHCrqUSzDUOptRVHV4y5EOF3/FMEEA0DYyu?=
 =?us-ascii?Q?rkwpmgbsUj6pkaudH162ZwesPJAuY+cU7tjCi6TmotMJ4BNuCF/eC2xJtlFi?=
 =?us-ascii?Q?RUFd5Fw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6WMDtGCg0pYJCv62WQbvVJiKSS2M3ynNlxr54ePfaKwypdfOt+QUGfJ+xbtd?=
 =?us-ascii?Q?IbzFEjNMjWL8fDyEQwzu3aQNV3iaCGl/KdUENA0Ka6/4dy4WTyqTfiLQTWcm?=
 =?us-ascii?Q?Cw7t/P4HinxIgcDasTPTLKTWavMej8JhIISVehhX7WKSMjLWe2DHQ91HIB8e?=
 =?us-ascii?Q?D98BhBcGhaq6vkDtNyRoj6fm2KS2C1+s7HekMcbzT5eOEOjSvd8J2uzYND4L?=
 =?us-ascii?Q?TmaApiKLysYPNu0WdPBhDoNhyE9IpX9IJWcL8H81stpREA8Bk/tNw3vi9yJX?=
 =?us-ascii?Q?O9+G6GqrTvUp6h5Vn+twN2bxIQ4DMQ9WpWnidfc9yPKJ+VjnGPL9KZ0sVm36?=
 =?us-ascii?Q?PlsOAG5FmrL5nn3oev5PrSHS5fMLLEq1M4u6UOogOqE1opstOOlqhMCyEyil?=
 =?us-ascii?Q?pgN9gmK5hptBe+9hoBApbd8TTAtoyBrNI7+k//N/8mBmsaBVmYfnLRPRtpVT?=
 =?us-ascii?Q?9QVzxasfK3KOVbkbWQWIUa0QeSd6bC7We+8Ezng/+RsrDt8TYNvcNAw8ojhW?=
 =?us-ascii?Q?ZqWgC4x/VPqsY+4NX0K82CHqsQM/cW5LDR8EjiiH+X73tyBlQpoI/dZU2unt?=
 =?us-ascii?Q?zvWZjTXinSXSkcpxR+8Xt8lqSndCS57A/lQKjVYOQd9mih9nU1ifbLpu0skn?=
 =?us-ascii?Q?LHV+pSy1NdLYXo2eBLIzGvbYHYjfTgVSmMiuVtGi8l+qe4o09+4NYprHnsGj?=
 =?us-ascii?Q?9CA+zk+ieVNTDdXgCfF4xjBfXptbzjOok55CJbXqCPz8uid/f/MR28Avdh/8?=
 =?us-ascii?Q?9QosPDdX9nHM2E062ii/cScPTsr91Tz0FvbGA3n+2CAJSQa+w4EJr0YUZ8ll?=
 =?us-ascii?Q?PgEEGDkDqyqWkENlUswEgz6e/OFidCTKgbUZvQtVQjNUQ2BK2BuDrUVTBu5T?=
 =?us-ascii?Q?3WmRRGpe/kHf/47ZQLfmq8oNkI2zkKmCqJMF7Ux8PMwcZmCtE5czekueP6PP?=
 =?us-ascii?Q?3ecDQoIw5TTITqk3cKGpMe8vu1js3YJeqhNe/4wDyJ1imoztnLGLFfmq0CGP?=
 =?us-ascii?Q?Cy8krB4ZWzvwYrt3RSIcDUJ6W5Y3MVlvbiqAzEcGCBY6/Ha/nV6tUKDzF63T?=
 =?us-ascii?Q?YsETogNYow3eFwJaKeZQr9A6HfhDq6EiT1Q83G7oW9xzeKG0M87CId3S8JWQ?=
 =?us-ascii?Q?V8KibWGuE2wdlq1Br8XCadAoZBMhpv5+dbGn2dRROpFB8kzhGtLXtyz8UWXn?=
 =?us-ascii?Q?oasmpW0CsUApU7NQEWS5APissD8ihmU1ccUlMbab1vZR3Qg3trZRhpuqPvOM?=
 =?us-ascii?Q?um5KU0n6BFzw3rmZGqT/G/anB2KreU4QJZE6dQnAubjoz37Lr8ex3MFdHDa0?=
 =?us-ascii?Q?JnGyO2FRka2+WkNX6agNX2kEFvjfMMChJt/CsSDydKGPBESzkW+B+7RnteOG?=
 =?us-ascii?Q?efr0uMgJSWL0I/CftboBUmAhO18XzxrlPm5CaCLNlhXs4aT0pgdewBnPhDcu?=
 =?us-ascii?Q?rtTY1qjWEW8egdyo2QfvZEGwHxpgyMAIOk8/0g00tuZ0qIdY+jkvatTSbTj0?=
 =?us-ascii?Q?5LKIXzTPeLr/PDCHKfFOw2demm1nYWhCMvvmWMGoFNeCgVyp0r/oqt3FgNdV?=
 =?us-ascii?Q?yR20/q1r9ZBgaapx2j0cDXq/Tu4iuf98ns0p/I5K?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f96381d-9f82-41aa-8cee-08dcfb289918
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2024 10:24:56.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 230nyStkVkNjafvOuV9MdH3/IB5vu6d+9v9QvucTriacwvQRAH5db3NsLBz4zgf4PdPq5oT9UQXJMpbiz9Xt4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7364
X-OriginatorOrg: intel.com

Hi Orange,

There are two things to do:

  1) Set ' edac_op_state' correctly (preparation work).
       This is provided as a separate patch in [1].

  2) Add polling mode support (your current patch).
       Please incorporate [2] into your current patch and update
       your current patch on top of [1] with the comments below.

Eventually, there will be 3 patches in your series. Could you please
re-send all these 3 patches after you resolve the comments below?

If any questions, feel free to let me know. Thanks!

TIP: the command below can quickly provide you with useful comments for you=
r patch.=20

    ${LINUX}/scripts/checkpatch.pl --strict   <your patch>

> From: Orange Kao <orange@aiven.io>
> [...]
>=20
> I have a PC with Intel N100 (with PCI device 8086:461c, DID_ADL_N_SKU4) b=
ut
> interrupt does not seems to work, even with the following configuration i=
n
> BIOS. I am not sure if this is caused by a BIOS bug or not.

Tweak this commit message a bit as below:

  Some PCs with Intel N100 (with PCI device 8086:461c, DID_ADL_N_SKU4)
  experienced issues with error interrupts not working, even with the follo=
wing=20
  configuration in the BIOS.

>=20
>     In-Band ECC Support: Enabled
>     In-Band ECC Operation Mode: 2 (make all requests protected and
>                                   ignore range checks)
>     IBECC Error Injection Control: Inject Correctable Error on insertion
>                                    counter
>     Error Injaction Insertion Count: 251658240 (0xf000000)

s/Injaction/Injection

>=20
> This commit tried to add polling support.

Tweak this sentence a bit as below:

  Add polling mode support for these machines to ensure that memory error
  events are handled.

Also append your "Signed-off-by:" tag here.

> ---
>  drivers/edac/igen6_edac.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c index
> 07dacf8c10be..5027070410a5 100644
> --- a/drivers/edac/igen6_edac.c
> +++ b/drivers/edac/igen6_edac.c
> @@ -1170,6 +1170,19 @@ static int igen6_pci_setup(struct pci_dev *pdev,
> u64 *mchbar)
>  	return -ENODEV;
>  }
>=20
> +static void igen6_check(struct mem_ctl_info *mci) {
> +	struct igen6_imc *imc =3D mci->pvt_info;
> +
> +	/* errsts_clear() isn't NMI-safe. Delay it in the IRQ context */
> +	u64 ecclog =3D ecclog_read_and_clear(imc);
> +	if (!ecclog)
> +		return;

Add a blank line here.

> +	if (!ecclog_gen_pool_add(imc->mc, ecclog))
> +		irq_work_queue(&ecclog_irq_work);
> +
> +}
> +
>  static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev) =
 {
>  	struct edac_mc_layer layers[2];
> @@ -1211,6 +1224,9 @@ static int igen6_register_mci(int mc, u64 mchbar,
> struct pci_dev *pdev)
>  	mci->edac_cap =3D EDAC_FLAG_SECDED;
>  	mci->mod_name =3D EDAC_MOD_STR;
>  	mci->dev_name =3D pci_name(pdev);
> +	if (edac_op_state =3D=3D EDAC_OPSTATE_POLL) {
> +		mci->edac_check =3D igen6_check;
> +	}
>  	mci->pvt_info =3D &igen6_pvt->imc[mc];
>=20
>  	imc =3D mci->pvt_info;
> @@ -1450,7 +1466,9 @@ static int __init igen6_init(void)
>  	if (owner && strncmp(owner, EDAC_MOD_STR,
> sizeof(EDAC_MOD_STR)))
>  		return -EBUSY;
>=20
> -	edac_op_state =3D EDAC_OPSTATE_NMI;
> +	if (edac_op_state =3D=3D EDAC_OPSTATE_INVAL) {
> +		edac_op_state =3D EDAC_OPSTATE_NMI;
> +	}

These 4 diffs are not needed after the separate patch [1].

>  	rc =3D pci_register_driver(&igen6_driver);
>  	if (rc)
> @@ -1474,3 +1492,6 @@ module_exit(igen6_exit);  MODULE_LICENSE("GPL
> v2");  MODULE_AUTHOR("Qiuxu Zhuo");  MODULE_DESCRIPTION("MC Driver
> for Intel client SoC using In-Band ECC");
> +
> +module_param(edac_op_state, int, 0444);
> MODULE_PARM_DESC(edac_op_state,
> +"EDAC Error Reporting state: 0=3DPoll,1=3DNMI. Default=3D1");

The driver now supports polling mode or detects it based on the configurati=
on mode.=20
Please replace this line with the one in [2] accordingly.=20

> --
> 2.47.0

=3D=3D=3D=3D=3D=3D=3D

[1]
From 182c717f9f46a9dc0711a8d9a1c42be6deb2cdb3 Mon Sep 17 00:00:00 2001
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Date: Sat, 2 Nov 2024 16:15:09 +0800
Subject: [PATCH 1/1] EDAC/igen6: Initialize edac_op_state according to the
 configuration data

Currently, igen6_edac sets edac_op_state to EDAC_OPSTATE_NMI, while the
driver also supports memory errors reported from Machine Check. Initialize
edac_op_state to the correct value according to the configuration data
that the driver probed.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 189a2fc29e74..b6ac14b69358 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1348,6 +1348,15 @@ static void unregister_err_handler(void)
        unregister_nmi_handler(NMI_SERR, IGEN6_NMI_NAME);
 }

+static void opstate_set(struct res_config *cfg)
+{
+       /* Set the mode according to the configuration data. */
+       if (cfg->machine_check)
+               edac_op_state =3D EDAC_OPSTATE_INT;
+       else
+               edac_op_state =3D EDAC_OPSTATE_NMI;
+}
+
 static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *e=
nt)
 {
        u64 mchbar;
@@ -1365,6 +1374,8 @@ static int igen6_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
        if (rc)
                goto fail;

+       opstate_set(res_cfg);
+
        for (i =3D 0; i < res_cfg->num_imc; i++) {
                rc =3D igen6_register_mci(i, mchbar, pdev);
                if (rc)
@@ -1448,8 +1459,6 @@ static int __init igen6_init(void)
        if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
                return -EBUSY;

-       edac_op_state =3D EDAC_OPSTATE_NMI;
-
        rc =3D pci_register_driver(&igen6_driver);
        if (rc)
                return rc;
--
2.17.1


[2]
diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 4f38bb1c1fc3..c8b6e41a12b5 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1368,6 +1368,10 @@ static void unregister_err_handler(void)

 static void opstate_set(struct res_config *cfg)
 {
+       /* Only the polling mode can be set via the module parameter. */
+       if (edac_op_state =3D=3D EDAC_OPSTATE_POLL)
+               return;
+
        /* Set the mode according to the configuration data. */
        if (cfg->machine_check)
                edac_op_state =3D EDAC_OPSTATE_INT;
@@ -1505,4 +1509,4 @@ MODULE_AUTHOR("Qiuxu Zhuo");
 MODULE_DESCRIPTION("MC Driver for Intel client SoC using In-Band ECC");

 module_param(edac_op_state, int, 0444);
-MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=3DPoll,1=3D=
NMI. Default=3D1");
+MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=3DPoll, Oth=
ers or default=3DAuto detect");


