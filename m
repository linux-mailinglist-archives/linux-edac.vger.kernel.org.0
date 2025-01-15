Return-Path: <linux-edac+bounces-2921-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D028A12502
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 14:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4571C1884715
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 13:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E324385D;
	Wed, 15 Jan 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XmnZM16X"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8D243855;
	Wed, 15 Jan 2025 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948294; cv=fail; b=fMbJ6QD4EqPq16OWiQPk5fmqhWw+CycjIu7bHZPHkzl7FJ8w1Dm5W5DvjJKjtaVYjUhFXCIo84wkBMEAeH29K+iwmv4/knNtdYxNp3vpv/DjTr+ShmqGW1yeS5+t2YKXDZSg4Hkl4BAqf0rNALQsHLjgwDCFBuN6rb5l+lo6bdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948294; c=relaxed/simple;
	bh=ML4vmQM8RMZYPOndevbVn9Bs44mqYsofv/1d40SegTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OsebFHS5Miqh1Q0u0kKsx4U1PpSDzbAabTDK+hQkP+8g9oq8APhY28qKp009UBMn5EjG0THLQUPXP4MXxT5IfO/HKic8ZA2Y9jIBELMVsq7oapSdiXw49k5fKbj6crceeFFDtH0FqywlkiqOwxnIzvDIsIbQIjdwxvr1KoNAYLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XmnZM16X; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736948293; x=1768484293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ML4vmQM8RMZYPOndevbVn9Bs44mqYsofv/1d40SegTc=;
  b=XmnZM16XrYWVc/oYJDXHEh/QdaOVt44GTYdcNEpUNj0vLSgg+niCBuVi
   Y/bVnW+6fY27o/3Rc78n0MXFEaR5DB4gejR76QEmjoKap+FDubqUK/fJi
   Jl59PzpOrBPw+mx8j4betr2gepaHTL0nbOSPLNR3myKj+O/rNimQlLRDV
   1kA8kcgNTWykSHadsw7VbDc/Gri6HBHEtOQIOfY+Y5xWv8VybpkY+XQ6N
   +wbqDIH0FF/spiquUGWaC3e4/XQ2XcG8z2e4YAbeZdkapIvAA1+RUb7tM
   24uf1n6xLFeJxBHHrdjm0tH8IYLI6n9cEj+gCuKVKV3Yb3IWq0uwezpAb
   g==;
X-CSE-ConnectionGUID: O7lBudaARpSoRzzoWyo39g==
X-CSE-MsgGUID: TRlF71hSQNmPxo2Rj8swGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37166893"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="37166893"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 05:38:12 -0800
X-CSE-ConnectionGUID: qHvPwVyWR/y2um2ZJ0tEig==
X-CSE-MsgGUID: ByHUIsV5R7iUxKSUshbkGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106007882"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 05:38:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 05:38:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 05:38:11 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 05:38:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePi60zds2o+ghRJnRxJpX7Ps9HHy8lN8QttXXBPF3ja4U68jT4BeXs9SAdsKmwA+duyAPQxh+Ers1KkDN9IyYEa61a1PS17Ncv+z3D7hRRNbsx2ohxd6CvGGAFaoFciKDaHvqOx6HYSm7mw53EZ00xg9GJXRCUm/EHahJzqYIcsXsoqnenIQ2svMBYPNvbjLuXoyZ/s30Lnty9Dk6rajPnfmzE1Z5MlvlkxQNVghHSDa3s+253cEupndQerhZ6t3GKc9h1v2peW9rdcryV89CW9dju/nH8//WBMcB4cgKrLw7Shf8Z1WPD9Zsyr5/Cm+3Iagkqh8VdjySlvOYSkdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDocFRc9pwOwag0pvLFhOrjWVX51liH+bHA2mP1EgZk=;
 b=koTvtSh/5wbFF95yDi/eUlklRG0s59uHVg5ZS+spggt48N8znotiEJO9iK2QiKpvvc87ApcBsPXDsA1jhUSJ31Lk1sHYLSehO0CHT7d55VwcooIpMro/P3eGLtbot62EwR70rLeZTvXqMV6BgcLR/HcBacvrMVWEZyaRxUiYe8/ei+TUQ2b2jNDmdHTHtkMkPnQyyZ96iorMz7sf+EZM7rtqKqbx/WvR6iT09gke/f2nsSBZ+rV/ddro4Uus3o4XuTzOPfm6/q0WIeJqKI0u5ftKkSTgYUOtvsu3PaTUhZGXzAn9rZ+xhvk1wW6XoMEOV5EDPN4Xl7k5Mai5BmazmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW3PR11MB4540.namprd11.prod.outlook.com (2603:10b6:303:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Wed, 15 Jan
 2025 13:37:59 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 13:37:59 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: RE: [RESEND PATCH 2/3] x86/mce: Make mce_notify_irq() static
Thread-Topic: [RESEND PATCH 2/3] x86/mce: Make mce_notify_irq() static
Thread-Index: AQHbZyBZ34apewULb0irUKQ0OR3uHrMX0XwA
Date: Wed, 15 Jan 2025 13:37:59 +0000
Message-ID: <CY8PR11MB7134CAAE935E2C6941E496E689192@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250114163722.34850-1-nik.borisov@suse.com>
 <20250115073640.77099-1-nik.borisov@suse.com>
 <20250115073640.77099-3-nik.borisov@suse.com>
In-Reply-To: <20250115073640.77099-3-nik.borisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW3PR11MB4540:EE_
x-ms-office365-filtering-correlation-id: 2152978e-beec-4a42-f858-08dd3569d380
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DYSBGI6xv/IoXaAGIG5eGV8muABHW7i4xIkVet/+Mwvc2UUwLankHUNKqzeU?=
 =?us-ascii?Q?tF6ZSsqppPbJZ8nwNmXUK1GYb4arwn1/A6+YPajC7bOrGKspD0f6UynVZe05?=
 =?us-ascii?Q?BLj59/WyEHHgYFxOxFRjrnXvECYrFjh8AvKqywSxNVhMNZGr8B0/ndtPhoSU?=
 =?us-ascii?Q?WQb7C3o6QHc09m9JxDS+4s3bFpvOdqszqO1qy+usi9VtKoPvgyXOLmK/h7NV?=
 =?us-ascii?Q?vb+aibG9LI+j0/3xAKbFqnoFGUID1En8aTAzTVRF6WP3bHKgojqoQwled+N5?=
 =?us-ascii?Q?mAk5ujUpmg4iUUy24BJyTdFSaZ147glno5PwQH+g2FcKy+e070Cc8S1XoQPV?=
 =?us-ascii?Q?6BbrO4kdTO6NltgL0JFi8c1f3Uxs2VmdqD9+1KVG3L4mgzgCkd6KTzhT45D/?=
 =?us-ascii?Q?EyojQ+IApz/wGr2bwvQZ1t6Wr/u/m/dbUpEk5lY77hQ+HCCehFcZQbTcG+ZT?=
 =?us-ascii?Q?Lu9y0GQbdZvL2hTwnmmYyuvaUmCR6pc+KeW7C1XF7cj9mWek6CetMeqd4kDG?=
 =?us-ascii?Q?ehwIqzxUtyLfuE7iFoyzh6yytzURCbu+shMso/QBO+MahFyplg3O4vjI05iv?=
 =?us-ascii?Q?D117StIroqXw/z3xE2vkeeaWdOcWFqVHJovEtOHDfEWIqWz+kPH77N5n7vK4?=
 =?us-ascii?Q?fvlufJtP0wv1y6y6/E/udms5RZvP3TVcxEeBVL6Pix4ZXS+0QUtzuhBFZQCf?=
 =?us-ascii?Q?GSy3hPwEWsQUiN2j7qOQMdoZXTfQT3Zi7FRPpSrhFhau5nh3RtHcY5Js9nUM?=
 =?us-ascii?Q?yWh3fSfMabbHc+Tf0M1HBB9KAj9O876q9SV+AJ/FpNGJMrdSBhVTUWbYa74g?=
 =?us-ascii?Q?De5rfIqSdAMkGPHwIG6ncx8/a+/FNqqT05szKousvU2VcjV7daN2MsC9DaCo?=
 =?us-ascii?Q?CDxU92B+DKyzmptlgB99ufhatcfnL+9cS97H+4NyLCVCOvgBLCpiKE62Tae+?=
 =?us-ascii?Q?OWHVcraY5rR+P27Ty+AmoEoAiTSBO+tixe8PBOAuXVpb43VRIT2lXgPHwlfK?=
 =?us-ascii?Q?IY8Mw96W2X6gMQmOn7c3aeVq11XZd2SWVr89JkyDkCTjkxIG0n3X0w6uTpR4?=
 =?us-ascii?Q?4TVUWOo+wpXgeEcnb5j0tJC71w6y1bAfoSoiK15kcQ8qszMphiEzuJv6r1Eb?=
 =?us-ascii?Q?/qu6SO0JLeNthhj1S7YktHxm3p9956zqZLUXl3j4Ij8J/E38zgO2i0N0kkkk?=
 =?us-ascii?Q?TKKTm7rVEsnCiotzJ65e59TiC7xzOt0kAn0i9PjDOwzyR0aGwaSzyKaMTHgm?=
 =?us-ascii?Q?rfASWpet/18GXTeb7MlTq4AZUs979s9MrDWZ5gUcIuLg3Xw6qO2xrEoYXQMn?=
 =?us-ascii?Q?jVdfXaVIr9WKrb2/bVg/QGc3qAWofMWFjeGL8hjdjGToFXajLaJnhzv1xBx3?=
 =?us-ascii?Q?iusUeGvKO8rUyd9U4Dg9vJV0Eg/kI4oAIIx+xpEveKeoRAK6uAMXCJ7wZbL3?=
 =?us-ascii?Q?UvLvr0mzan6Ln15fLZ/qBzx9rsyJV/e0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7yPiedS9maIOQB25n+8ACF8AFPfgYWzPESNSG3IGTe3FRWqwfrkciZw9bceH?=
 =?us-ascii?Q?UpAbYqncZS4dHGtgVE73KpCJfBUYrJCiLJKpZGm3hK+bIT/FJTVD2sbTN50a?=
 =?us-ascii?Q?+opxwkmD8i6S2RM9NDZbe+iCifsb4opW7xbQOI/2Bh37jxWKCey5ozRGMQZu?=
 =?us-ascii?Q?7hv3sek7If2YmhR4Xp5lxpxFKTyl68PWnoBAxPbgP2lWFnU1L+eHyo4/WBLp?=
 =?us-ascii?Q?sdK16YNUEyljWnP/+D8U0xZohOeXFRyt21otHlVpdeUJVMgP8AV/NP3NVWoP?=
 =?us-ascii?Q?UqVgyrE0oYPv6PY6kK2Nr66wDzQGrfmtvgJySoSb42X9RUUHABvNt6KxTOi+?=
 =?us-ascii?Q?TAq2Pmg6PWiG+qpK92fQpsbHe9jO0elN94Wx6ilPUHn4eFmUVtqWqSXl7YLy?=
 =?us-ascii?Q?x22GmEa+aIBasIXHc0OhmPXOgWcUygiRmpZZPyDtIJlnmVlDl+rFurBMUv++?=
 =?us-ascii?Q?UC5TPu37PmY6qhOuDCki9T2edD3FsxsVj4eC3kH1zmv08Omji3lta9VyTdQX?=
 =?us-ascii?Q?uhi8l2H1824HjF9Bz1HiZJqMLoyziJc8/kATMysaqmQArFsHAzCTlfMO9e/l?=
 =?us-ascii?Q?KWZgJh0Ni5a9bC2MtmhA8+lFnBIoMNdS2AWbhLsZrxmn972v+SdyrX2Ll24H?=
 =?us-ascii?Q?Mh75qia3jOCfPkKc/oXMcPEBW+AwXUGLUpyCPfWi0T53ojavyMVdxL/qXrbP?=
 =?us-ascii?Q?Rj7UzeOPzR5tnb8HCON0nNgzRDHnXIjhLJnu9zkJ8pxgC/m3wgiyf6anML/Z?=
 =?us-ascii?Q?KP7ADUuQeY1zqPGAaApNNlaRFPwM1wxq7A0vWVYz3LQfCgTbcxT+eP0N97tF?=
 =?us-ascii?Q?MDjWiGJBTqMtpgJAxN6/KphWsosT/ZWi9L1fGPsz6L95uJsJ8J2B/aIkb+Ec?=
 =?us-ascii?Q?M0y3KfxHA0FQIEaymKcaqEqHYEXcEvIQQepcHduSK5WRYuodmyBck9uoisg1?=
 =?us-ascii?Q?PVrpgGXyDW3lrGOq6wv7rPP9vw0IAU18r5X+hRXufGhbVh+8729GdJSDl873?=
 =?us-ascii?Q?4rCbOmz5KAb7+iRdaFNaA98gdZYHwI2hvLzunOqTrzrHhSeQHPaqixTPjOAd?=
 =?us-ascii?Q?tWw0BPZOBpMa87EC8gLyR86h55frVr0zUx+AEwie+MWGS1vBxRj+SaXpInl6?=
 =?us-ascii?Q?8QE0BZ2bXCs/sHewSFNtDi3XEmFGdxPfhUjCJqpSDejayxG1Fpdd3a0SnBUJ?=
 =?us-ascii?Q?ruTo/iXuUIJRHr//v9Mto40dK6Oz+g+BMUZlsoHJZ9aPTNcrsB0F8klIzUwn?=
 =?us-ascii?Q?m3oja/JJL69bA0vcHNUX5t/wqWlMN+F2ymPcSWGuF+PF1qTiky6J7EbiDH5p?=
 =?us-ascii?Q?IigoXdhe4+bTW1UDzdt1Hz1OdiDip3SD/RUzx1OJm2kx5jaTm2APG3mdO4yz?=
 =?us-ascii?Q?LCi8qhKO1wI4sDZUU1pmSePyOg8xTXCBJ5OtkVlpPM5Ic18NO2nphk2C7e1R?=
 =?us-ascii?Q?sdnbqyHNbvunmU0C7YxbeYN82cDvH95DnV7zMZrNt95HbLHgTCTQty7VcGgT?=
 =?us-ascii?Q?sU9LPEK5PH/A1Sdh1E3NwRkoRj3sfsAKl8V3E7WnH+l5/6HkEfcnrPfHfJUN?=
 =?us-ascii?Q?20YNUABHO1V2aH9IRlM85tU8LFcmtU1OxihXP4rE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2152978e-beec-4a42-f858-08dd3569d380
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 13:37:59.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZmkOLI/Arm6B0tHc5aVBAl4ktC5U0dRVioHilZ70L3F247qtUDK666nyWt5IlrWEJSU8wXQCXcfOchJWuVUKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4540
X-OriginatorOrg: intel.com

> From: Nikolay Borisov <nik.borisov@suse.com>
> [...]
> Subject: [RESEND PATCH 2/3] x86/mce: Make mce_notify_irq() static
>=20
> It's no longer used outside of core.c so let's make it static. No functio=
nal
> changes.
>=20
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  arch/x86/include/asm/mce.h     |  2 --
>  arch/x86/kernel/cpu/mce/core.c | 43 +++++++++++++++++-----------------
>  2 files changed, 22 insertions(+), 23 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h inde=
x
> eb2db07ef39c..6c77c03139f7 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -296,8 +296,6 @@ enum mcp_flags {
>=20
>  void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
>=20
> -bool mce_notify_irq(void);
> -
>  DECLARE_PER_CPU(struct mce, injectm);
>=20
>  /* Disable CMCI/polling for MCA bank claimed by firmware */ diff --git
> a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c index
> 23e5e7f7c554..89625ff79c3b 100644
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
> +{
> +	/* Not more than two messages every minute */
> +	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
> +
> +	if (test_and_clear_bit(0, &mce_need_notify)) {
> +		mce_work_trigger();
> +
> +		if (__ratelimit(&ratelimit))
> +			pr_info(HW_ERR "Machine check events logged\n");
> +
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +

Did you mistakenly change the return value type to int?=20

