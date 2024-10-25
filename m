Return-Path: <linux-edac+bounces-2307-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D61A9B139F
	for <lists+linux-edac@lfdr.de>; Sat, 26 Oct 2024 01:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F501C217BC
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 23:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93201DD0CC;
	Fri, 25 Oct 2024 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7+TAdoX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB211537C8;
	Fri, 25 Oct 2024 23:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900685; cv=fail; b=X/xVpvs/E2VNN01WRIFiZ3Ew0bfc5Q3t78kUnIZg1u0M/y2Wn0Z3ZJSYLRQwU5HhcJj1LQYy46a1Rt5Rd7cDNBUOzIyYa78ZPZuIVEfenFNQhqHaWd2GzgGhrggwEhsSiCAg1ji0DmQ08QPSqmC7JX/y3mDvBP7B6MK4RBvbKBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900685; c=relaxed/simple;
	bh=mCC4xY4O3ggfEKNQDDuEwpZ7nEOLNLgilIGNK9yHQUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iP6RlAJU8S5eXY+nBoqaLJOi6YIaZ3IS8hho3ILQpJgdgFRFpiQgAiTAzgf+8L5FCqQ1frcV+OXDL4V7etogFlBfvce5eQn/BxtTEtcMrjU8kk1sFnTUh0HIOX3aec6MLg01fePkvLCGblQr8V9ZJWngkpnmJ4/Eoat2pTCW9b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7+TAdoX; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729900683; x=1761436683;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mCC4xY4O3ggfEKNQDDuEwpZ7nEOLNLgilIGNK9yHQUg=;
  b=k7+TAdoXIDdb/owPeM9/VEG1cdXFmYz6MF43PdpTIX+TmSEYLgXrOZXX
   twNvt+JzQo4j0g8T4e2pf7xl1P411ou81IWFnbLAZjw/y3XhZixt1YYGZ
   DnUyV2Gq+mjug3Tzw6UHS1a184wM8ICFPovUOwimXoSBgLTc6CiJ35qC4
   WxVrJ9GEErzArfzoi/Tbt4I1LEQ7IbNMcyjF3P1Jf9xnxtIKUt7p6lAWf
   YAJw+UE7MTQ4RWY8XGVon6ncPI7DEhrayX8weBfM6qkzlSPpY7VJXugh5
   Mh6Rr1nM//qp4yB/1WIL0K8WkDCvDxh2vsLOEVTwc6wUi4tj0enT6rDnP
   Q==;
X-CSE-ConnectionGUID: xlGqH7tWRgmRUXUl94AP9g==
X-CSE-MsgGUID: yEWIxkrES2SOaNAzENeTWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29696696"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29696696"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 16:58:03 -0700
X-CSE-ConnectionGUID: Ws2ZPPD9SheAGWfZGKfpMQ==
X-CSE-MsgGUID: 6t6vNSgbQEeMFrb7S/KOKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="111907493"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 16:58:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 16:58:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 16:58:02 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 16:58:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGGa7J3q0zAspbr+YPfIvjNCcR77AQxxNMMbeU2AkP8eXiUoqLM7Py4kC3LtU4FoRsYPjXGAzlFBLhwhmEiSVK+lKj+JZpR6pZyRxpX1Zm8LeDc6cRriLuij4n5kUibr6j7FjtdpQjuh8ByzPGzq4/AXdQRakoila3TAEHYsTtzY1zGtt7SKbn+NmA0SMy83f5J/TmQ/oNA6KyeChgUfxYSR8D8B83B6pqkZcL6ArgkNe47Q0RPzwoNIv3BE2WyPd4GwQlw+g4yHHOvExooxJOjUQcN6yaOW+/KjPM3n6r8t8QHcjGhqoRxsz+864Y2y7+s5/a64F7RCV2OZB4NRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KexOP18i4dc2PU60H/yF/0ZVGiPs+pnLNZV9hbwg0I=;
 b=dM2K9SLapcPJjs4OlU14WrLEi2Kjs7OmtPVEPoy0F3fVcRUHLaUrVUW5QcnC5D+3rWWpg1l/jYKBL0Ws0bNmPdYfZe1fEblfolCfbEHaA+uinkLStmJ3Nw3vLYaF0S/75fNdxzAGXyjMIzjw2mFuet8EO9lbhljCHiTPP6E/Achma/LvDQ04vSZGJjxa4S2l+llSsNdzdggecTD8x+HmURb90qgR2YDD5o8n6tOB63moEpYxWHPrPFH6J7I7T5gPROrgxezJbljMbuyLlyLgyoayiOTLZggPG2WueUUcyvxPLsotcs269Huv59PHeu50vAomcb76086CC0lRtzfdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB7908.namprd11.prod.outlook.com (2603:10b6:8:ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.20; Fri, 25 Oct 2024 23:57:59 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 23:57:59 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@amazon.com>
Subject: RE: WARNING in lmce_supported() during reboot.
Thread-Topic: WARNING in lmce_supported() during reboot.
Thread-Index: AQHbJzOFdPGloVTzgkqFRZzJvO9WD7KYIlkA
Date: Fri, 25 Oct 2024 23:57:59 +0000
Message-ID: <SJ1PR11MB60830F29ECFA61275F56CA4FFC4F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241025231320.45417-1-kuniyu@amazon.com>
In-Reply-To: <20241025231320.45417-1-kuniyu@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB7908:EE_
x-ms-office365-filtering-correlation-id: 2228b7a1-b9a7-48d1-7748-08dcf550dab1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tXlD+xwYSiZzaWAyym5DbSzzBQai4sYty/q3JsGJ3dqiad12DAlYtrYapP1m?=
 =?us-ascii?Q?gm49CWTyaxIoFWtaXwOW1f5c2v1GuclM9wdFyDJ4vRulXAReKBYfH8Bmbwo5?=
 =?us-ascii?Q?wHVepS8ZGXkhE+g6AOuUDA1JbyZiTJEaJr/P6Zz/O5j+tb6iJCqqRw2DIi9I?=
 =?us-ascii?Q?Eq0Wz1Uwc+a/nY73zayApvH7TLOhlMhqgrgT07i1UeL5P7nhxqf7YSL8MAan?=
 =?us-ascii?Q?gc+YBut182KuPoYcfxFo/21R2Hde8CdBiS01p+NK9nB/5RYn74WL7J0bY2vW?=
 =?us-ascii?Q?mOlaZ+b27xkHrpvm0R6WuUb88xor99cS/Aq8+xuZFLL9S9YDXw1rDeziuz+a?=
 =?us-ascii?Q?qZo5+iqtJkeWn+UZ78vwbfrQi+6blmeoF1DFfTQUm+tJKPoyTK8sCok3zEfR?=
 =?us-ascii?Q?6Xpid+ZvMiW56Ugt6RzWKkElkDIATnbZP9CDUMnw+dhEbmqmU6D9w+emgZyH?=
 =?us-ascii?Q?jWqc7N5vM/FBhuZCPu7MneLWUtXCt4G9tZCdEM1KKiERPJaKXqcqQ3+tjA6X?=
 =?us-ascii?Q?odu856yVAVIiDBHxGmKPsuW3JovZNF70jgOooeAJjBE0PAyvB6LVw4mc7ybz?=
 =?us-ascii?Q?2d7PnS4I+y3Srie4XIKhq4b5lBUYm76p8UZ726LpAUFV+WnPwjbjNR10DmLu?=
 =?us-ascii?Q?yY0k7LjvKc39Ebr8L5xQoOZZHixJ+9nF4jpOgPOqDOriX5T9Vfsr3fpDHvY0?=
 =?us-ascii?Q?9o3xOU3apX/53Id5w9eRNjyf3GAs2WjX6qyaNATzH9tYN84CUbtJXFDXL55P?=
 =?us-ascii?Q?eX/wzLIZk+mnaW8PeFp2fFsK1S9TIZDSdtY2kJTjGSIaP7xUriKS84sB/z3q?=
 =?us-ascii?Q?yNz9iS7J+Wi+HNDzudJG8+1ehn2rDHcsEbR8nCkdIaKiAsf4RBNaGPvuebiP?=
 =?us-ascii?Q?hnGnRrkAhS0GpqEy6HaaFxt+at0OkD8zn0yb5gOf2qdN9zMdN9EPB8T497dJ?=
 =?us-ascii?Q?cEEpn0VwAUUoJdO/8vw2BIoC188W3jzG0E1NMBWNNoa2H+t9c0nE/8womaPh?=
 =?us-ascii?Q?OR2/2Tx/GfYTAzYp31Gf8Zhf5x/4apBMQ6/S/9nWePRh/8SD8/57hyV4mAIt?=
 =?us-ascii?Q?e5IARmmRKOQLcQ8Q+5TA+LOLt2G5LJeTlZtMy7KikS+vG9bgXqqCCgS/VVBY?=
 =?us-ascii?Q?B0WWvvrnbNNP7KRIT98mlE5gc66w5dkyjFIFynwyEnMQVYSkOIu9weS6yBUf?=
 =?us-ascii?Q?betf4zOqhbPq8XLaLERzAxUYOmK8Pb97NgpI2cbXt+YB+t+jgc7Ik3UEQwyj?=
 =?us-ascii?Q?Lcf6JwI3I7WCC7AzEBggtj9ysrrQw8zAu2gmckFiCUa6p7HKmBDnl19mFbQ7?=
 =?us-ascii?Q?CnWoKIG3C8tV2Hja+6vddvek?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BD+vjlKaTm0wpvowkoK96mImYBIxyYCZug1Y23k/e4+SgDydDQb2uk3ubnhz?=
 =?us-ascii?Q?D4D3IZ2MDMXufymmzWjzA0IfZUaNxS/YBWfIn3+siuzgvM0FSbEuP8pi41Vy?=
 =?us-ascii?Q?D11yS9ZlAwYXfHWkl3Q+KcrAbSDo6/vp99xu3x2Ml2GneREAqd2naGRvG5PE?=
 =?us-ascii?Q?JtA5avw2V1kX0EeMmKyPwLpiKj4y1Bm8EIP3PbJ+o6W309iDasQ7i8Be7FpJ?=
 =?us-ascii?Q?4Jx2PNTNh/Zuak3T80Io9x0PQJ5HlX07fu7YpTyi5LfOZcIaVBMKvkLgwj4O?=
 =?us-ascii?Q?fbTTNodgw253IrTSUQ2e75c2AkoOTYmIZH42sCfAIgYVCtmqb+zI5+iuduPm?=
 =?us-ascii?Q?jv1swBcV8C23YLq6CEUgWIThiajqyYF8p5ygglinkOTGT1ahgAwmnXJtJjw0?=
 =?us-ascii?Q?kajvfcTrsL5xIFBSZhzthtJJsgQuRCFIlUb/IV4JLFdaPdxtreH9iSU+Hs/o?=
 =?us-ascii?Q?7QvcL+iy3RPvdtf+bubdbP7mdWYCs8+EOmYdPq1yReqyfguRMzuWRFrK7iyB?=
 =?us-ascii?Q?TLMCSnYuUd2EJw/EdVNsS24CEFMvE8jVSq/f1qrXMMZrFr7acyY2DiG1MvYs?=
 =?us-ascii?Q?XFFCBU5oBYmJm257J6AK01KywVpFZKLwnZa3TWme4PFG0lItXEjV6rn8GKmA?=
 =?us-ascii?Q?FAuQJsiRFq2tFXfQoZ7DcEZ09mu9j7mNvmDhFNACkL+wrJmRIE+xmuSXOXFg?=
 =?us-ascii?Q?dyaugTyK81PceKIir2YCL7VU/Yaxgc0D3KrpOoFwcUNGcsSLrPv4PIuYVVIb?=
 =?us-ascii?Q?sMNBi0GxCWAu2/M+f/TrJ1NsDYx+PFu9diArmHqGkF1pglSRGzeT60Y32Fx7?=
 =?us-ascii?Q?6RBIVPOWaeYFI9hAFplxsNB0uX3SChAq3lujbChonCPy4ecd07+iKz6U2m13?=
 =?us-ascii?Q?rlR+8SOW2vD457jNBDcoUR5YafpcJAKxzhg9kJDT7EXRx6XV80Ooy32XoDmV?=
 =?us-ascii?Q?qJzzakXlsNgXE1qmeWZFbgPOXJyC7i/UhEPQD/te2AzrhwBRDmEq3nUQikc1?=
 =?us-ascii?Q?oQ4GjiWtIbkYxg+Dyiw48W5GvN5KiHv3iytEfbN60e4xNAMmQbHVnEZ0OTNq?=
 =?us-ascii?Q?HOK17T4zOPPn7GvM2eiFjbGcOCUP4A/xza0KEIjET2lua041WLaX+LoVGT7+?=
 =?us-ascii?Q?tN2PYi1wHSZ0zwSuw2VaJPEuw5bkobIwnFlyd/MKFGv8JZgrs0E3aha6DfWb?=
 =?us-ascii?Q?+n1c8cUN9fnWlXNMtrBB4NDNRlDNwQibqatt+P/rRSyUthcTx/P3o73oVnUt?=
 =?us-ascii?Q?/rOa5LdwDxi3SHOvH1YS5aMaJaGjenq6zPL6CL4PoV6Wz4tSzDH0dZ6mrled?=
 =?us-ascii?Q?/67Pe8W5fKtQPmGTiTPe612lGqoet9/Y0Smug4ADTKFUtkwRqedsj4MGMxNN?=
 =?us-ascii?Q?xykvCVsYisBzqD0MYpSKQ5RJgqmq99fjNue2dw2Uq3YJUnrHmyk9nGdFgaf0?=
 =?us-ascii?Q?XeCCDJjPp8gOS1o/fr6IQ3IFyb7OHkqx1DbhM0t6hRzlJOTgQhTVMbu+CUqD?=
 =?us-ascii?Q?HgAA3yQPTKcCpqqcf1LwiiDA+ykPozmgX60UwtW6gYO+d89ravRfEIHhfBTc?=
 =?us-ascii?Q?/hKTWGsAAefwNomUdTe8IbnMg1d28jdgMniw9COO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2228b7a1-b9a7-48d1-7748-08dcf550dab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 23:57:59.4554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syin1UBftl1WFB79/lqxYDY5s3TzQsvhunSkhwNJydLyHRnOuEzgJohlQDlkHhwlM/pcAmJxZTnypMlv7cj25A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7908
X-OriginatorOrg: intel.com

> and the triggered WARN_ON_ONCE() in lmce_supported() is here.
> https://github.com/amazonlinux/linux/blob/kernel-6.1.61-85.141.amzn2023/a=
rch/x86/kernel/cpu/mce/intel.c#L124

So the warning is this one:

	if (WARN_ON_ONCE(!(tmp & FEAT_CTL_LOCKED)))

It is checking that the MSR_IA32_FEAT_CTL (MSR 0x3a) has been correctly
set and locked by BIOS. I.e. that LMCE mode can't be snatched away by
someone rewriting this MSR.

That said, you ought to either hit it all the time, or never. So this "some=
times"
state is weird.

Which CPU model do you see this on?

Can you please try using the rdmsr/wrmsr commands from msr-tools to:

a) read this MSR on all CPUs to check it is set to the same value and that
bit 0 is set to 1.

b) try writing to this MSR (maybe try clearing the lock bit (bit 0) or the =
LMCE bit (bit 20)
and see if that succeeds.

-Tony

