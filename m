Return-Path: <linux-edac+bounces-2462-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4939BED53
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 14:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D31F24959
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA82B1F9411;
	Wed,  6 Nov 2024 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHINvlu2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C195F1F9412;
	Wed,  6 Nov 2024 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898305; cv=fail; b=mkJwEfIwuUYnzwxs71p4g1N3A81tOc6GAIe45XRVBr/IyhKOr26OYhFdo8RZx//TpwNB0WlgK1fNaTI/r5XEMSOBz80BmJQzdz+wcjL2tLLP9rtdzWTed/sSB4rSAWPXKZaWCiFOSK2WgJWjO8oOaU4178ZRTek6RMUaUtKYak0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898305; c=relaxed/simple;
	bh=Oo6BiWdFMq+yLXMm05vD+M8XilTsGYjFQ2uDF7HdHco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D00Vc4i3skiWBROmh4O4XU9S1znb9zCLVAQ+SEjdrteyO//WlksjFwcGCasomUns+OLo0fPlTLPERrl3aQycimFT/Ox4N1yo8Mdj4Jgq4kU32tPRNdC3rvJjQNfIPTQYcDP6a3wt8J3hnUBUCqawci0K9fw9o5eOYEIb0vrQxS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHINvlu2; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730898304; x=1762434304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oo6BiWdFMq+yLXMm05vD+M8XilTsGYjFQ2uDF7HdHco=;
  b=EHINvlu2rq32kI+nJ9KcDTKwO4yvUP2vNm0V8iY8aR/LrGNKN8w+/Fwj
   vbUmp9iGjAD/KTTAiuxTMN2m0zz6L3+3c0qFJ+r7ZkGFRPcOb9ik3JFg0
   OfJHtdcguugviN4P6N5G3Bs+AjDzfwI6GZLg5GBnW2ylXLwW/KwPfgVY6
   5URJJriWAMK8Px5t0DIFxsU7L7rrXnb7Ys+ffLJG9fUqfXNigUyq00DNq
   dMTuX4Ti2uppyt0ZaUI29VrAYF+CRopMGQIAzM6B+rYfIPnzBaUS0ux4F
   gTKaiDFkhndwamLA+hdLy/lUnaS3W94dFoj0fEkoOv/GHH9i95704rHPc
   Q==;
X-CSE-ConnectionGUID: aVwxnr3/TDWndF8sVjvlsQ==
X-CSE-MsgGUID: U51xQbHFQ7WGxBw6SI+X2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41795215"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41795215"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 05:04:52 -0800
X-CSE-ConnectionGUID: NO/qMsEqTQOwn9AEiZODlA==
X-CSE-MsgGUID: vBLZ6oHbR8yww67yGXGDxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84887530"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2024 05:04:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Nov 2024 05:04:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 6 Nov 2024 05:04:49 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 05:04:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StuJYVW9scwR9oTLPNU+q3EHiUDPg3+WfW2Xer5Dcaw65jbpTtviFyn+I+RbNPCupo1RbJWscbgOpZ07pK8O+SDSUlTCAGQvhCFgQphfHdTiIBtJvCYXhulU9vIHkwn0dYCY+2DOSqXI+ALYTCnhtPh7xfNnwkIcx8ejQPMl7LzPlq0yheWVaDnTrVAruHPXc+2eVhfoR7GJZOr8o5EFG56OZhlZLGT+HwXR0AFg7QmL+owuOBhEEH7rIHbC3b2jswyF3u8B7uxc5wgKOC5Mg4VCIM1Ts5LWBaWC9rkUeruWa4wh9Os0lI63J3jXO5XL2MyOU7v4O3RNUoFMjjXQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oo6BiWdFMq+yLXMm05vD+M8XilTsGYjFQ2uDF7HdHco=;
 b=JR1mNbmQ12AYry8dpOHYDDWrAPqVYKbrOLz3aeBKxT0OKiOMxCrkekZjHJhA9ECGR+rrPeTDMbA4f4zxbSk8rcH7hp0tASfQ1btLkFKQPltCLLNVPUPc0aNykZAr5Mjp4VrZBEzgpyYJRmz8av1R1L390dJlZrYbqK+XZMpNwAZPIyhp3XKiUWBv0IobjA2bbEmAq/j3nwWjR88+b70wTCrBMTGcclUeS6ra4Go+eZb3VOshz0sEZrcRgAwXVogrW5FzvsK9eCQNSJDQp18qX8DKfoRGdTQOqmQert0ZOw0jgMK4fikhXeVcaNzLQHUQbz3RZbMocamhVaMsvzm0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW4PR11MB7080.namprd11.prod.outlook.com (2603:10b6:303:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 13:04:42 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 13:04:42 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Orange Kao <orange@aiven.io>, "Luck, Tony" <tony.luck@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com"
	<james.morse@arm.com>, "orange@kaosy.org" <orange@kaosy.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>
Subject: RE: [PATCH 3/3] EDAC/igen6: Allow setting edac_op_state
Thread-Topic: [PATCH 3/3] EDAC/igen6: Allow setting edac_op_state
Thread-Index: AQHbMEDudgYSPzLEIES3xCtrEHusQ7KqNm3Q
Date: Wed, 6 Nov 2024 13:04:41 +0000
Message-ID: <CY8PR11MB7134C2A2328E5B8B3285C81489532@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241106114024.941659-1-orange@aiven.io>
 <20241106114024.941659-4-orange@aiven.io>
In-Reply-To: <20241106114024.941659-4-orange@aiven.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW4PR11MB7080:EE_
x-ms-office365-filtering-correlation-id: ee1ddfc4-3c79-46e9-fde8-08dcfe63941a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ynEj14m4rnGSCcrY9osgIpk4wZC7YR49+zFWCggpxtadecGkAPulrwTPq8?=
 =?iso-8859-1?Q?y9MwkvnHBo94xHOFptkVPNqltFAkejxO2kYDzWXI06EmyTnnjWC+wHLMyy?=
 =?iso-8859-1?Q?T5zbT8r6Ml6ql6sp/usAFR4yDaxt7Qx8PMWBEj/eu2iPB/PENlyj4A15yJ?=
 =?iso-8859-1?Q?QygWbTWzl9MvJRoGuLIEl0xaSclQ/niRhkLxwHoIcf9bvyCNYYVQDhv13m?=
 =?iso-8859-1?Q?Kj0ElB5H5aIGWi5Gj6eDpW1EI0b8DznPqyXf7uZ9J9pA3xPO2jHFUg82Z3?=
 =?iso-8859-1?Q?NCr9FzLleTDkq2fZXTxIrHyLbK4or5FaLt2L100IrbdZQhtjju/KjUTxeG?=
 =?iso-8859-1?Q?UKWy695eWS4nOtWk9xyWVOCe1URPmAWegE48au1kGVmSBOQ6Xy/pD2mYAI?=
 =?iso-8859-1?Q?V4K9xJ/XpiInb8jftLcuOOU5nhjV+/x7ECz/MldiqWW+ItYJ9zEBoYYNiS?=
 =?iso-8859-1?Q?SazkHqZjEKKf2FexoFnws3KnhvT10DzqlNsHczYHEQnNaWROdovcJeHV2B?=
 =?iso-8859-1?Q?K6ELXzoPsbumip006XwNWfQ/afzzRGeLPyUTewLCsLG+O750ZzD3rShjx6?=
 =?iso-8859-1?Q?xlJ6zA816G6t5Oed1TdH74MUEWmsiTi7KzCOgxzLAt/Ey/0by6NLMD67WN?=
 =?iso-8859-1?Q?iU+7zGCrxLLoaUusYa90KZz7B6+I2FWEVTj/Gxv3HGjb0KZWdT71ZtLAFh?=
 =?iso-8859-1?Q?q++sIS7zLgQrAE7DVnh0nzUKBjG6tWjhG3RhwsjQxes4qGSeWQ6jS84ZrA?=
 =?iso-8859-1?Q?nL1xgK58vJtoapAMAMribbM6GAbJCUgjYifq/ZDnLTfu0pWj6TFCowPlNm?=
 =?iso-8859-1?Q?gZWVWwEGaiwBAVri+fVuw4TKY6HaxXrsTn+DPzuzRdpcrbnn00J3CcKPtd?=
 =?iso-8859-1?Q?GqsB6oI0X+yScripy9WO/vhX2UGNXo7SNssrGDUIT48vl6lfCzPIQLG5wG?=
 =?iso-8859-1?Q?xJ7yCFJLvgHF0TNkFZ+y1a8sVFi1j4n2wc7ksvBvPDdZlwv2d+qDKy3nrD?=
 =?iso-8859-1?Q?8749TgApxpIhePompSlWFTv9Fag+Wz4ZCMCxvVAAt/csL90ZMNdylCmI0F?=
 =?iso-8859-1?Q?k9TJd/YQT7d4UMkFqbk58U324vJgNI2Jql5otB8i2SPrAWcGPQ58bBkzsr?=
 =?iso-8859-1?Q?mD+RxlRe4HaaHvSsFCRlT3t849WRRrHak5Vbyymri8nt8KogS0eX22gc3A?=
 =?iso-8859-1?Q?MYk/PRWtFi69x8JIwfT/BnlMTJFMC62S07v/SNRGRJ+2wqdnGNblGgCjFI?=
 =?iso-8859-1?Q?dNOkoTA0vG4Kuan/sjp8tG2Ae+csAMwwJxE/pGstytDVx4/A4eWiv6QEWO?=
 =?iso-8859-1?Q?1m9yRY4B0rhkJzOrXUd90uZH3VPZb+qrElBrZieT25rWzJyhoaDUHT9GG2?=
 =?iso-8859-1?Q?Gii9oD27KeOBb9sof77Rf7ctdwymp62wtfvONVI1jywk2oRMqQM04=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/2rOsgsgS4nUudwaexwCGJSmKIM+3gzzKf4Ut2nPniwL/+r2GsrYSKWBfG?=
 =?iso-8859-1?Q?kaxwUKoHHQ6N1OghnTL2I303drAEI7EKDofJ9hYU3gUvJU/9PP9YaGWLH9?=
 =?iso-8859-1?Q?5KpDuH4L4D49oam8eVO3+keHxL8PFdds/uHQZRrhFvEP3U4/yxBbbx9uMc?=
 =?iso-8859-1?Q?ERMRAySHyFvWJo97MJzIGROasn/8XvRhCcg9pePeqwO0Xf4P76wNlpFPwi?=
 =?iso-8859-1?Q?nOdZvnbFUf2IEjUsRMFkbXIWdmuiO6N2/3e2wyVxzxb5LPKBzKx/BS5X+q?=
 =?iso-8859-1?Q?I/4+8hJLW5HefkTZrT/ydm4cBVSv2SU/qVY/GKTf+5kfdhNsouIZx4RZx5?=
 =?iso-8859-1?Q?GBzyv9AAjV50U7UZaWm7rSTGBLne7acWOBje9O4d2W+a3TxZVhT++HFHKn?=
 =?iso-8859-1?Q?d9audpXeWg7UlnAkf+f8dNgYBc3Y6Th54I5qh6GViRNht3zUbfo8IwWvgN?=
 =?iso-8859-1?Q?bqhYpcSJM3I5KfPrIqkuwrOpshfMA9ViCjoZUTN6wn79ZHxJF1IfTB+42A?=
 =?iso-8859-1?Q?eGdezGt/QoQYinGpgiQWeZWaH/4Jc9dnO95CPtYcbXcHFCGqWFsyswqj5c?=
 =?iso-8859-1?Q?4wRRiCFUxGNfVb11yMoshetJNhDx/3rxYAag/SUD3uU3Jb0oJHco7E1je0?=
 =?iso-8859-1?Q?7127Fw5KYiMjwmdXEGaEp5H1PIxJaE3cK0CTW4j4bhQ9ZLrSDxRij7OOG+?=
 =?iso-8859-1?Q?8+NOJHEEWiK2hL0aDbp26Hjkgm4UyKXoqVcVSFdj2EqVSnt3LxQqKoxLcS?=
 =?iso-8859-1?Q?yiYalTCMurpfdiovtgoeF/KYVxJE2JzKXnH8WsLSabqGrUE6/gowNaH3jj?=
 =?iso-8859-1?Q?+hUcVLXHXT1fvGySGm6Zna5lOPM7DLmr6JEN9MTOFMkNyVexRXuQHre2Bt?=
 =?iso-8859-1?Q?p6tyipjZvIia0ghII8fVd5R98AmhE/1bw7xny35zK59naQbDPI1hZcQnoA?=
 =?iso-8859-1?Q?JEqEQ7uByY5RFmq+VV1Yp9nFQoF7wnIFeoyTIYNW2k3GFjlgAsu8GT6SoD?=
 =?iso-8859-1?Q?Umj/rB6cqE9kMs/vZm6TitfVHfRPyCHaY/qThs1P4nJ76wqZqrZVRDBhzN?=
 =?iso-8859-1?Q?1T8+hHQU4ooGY7Zno27a9+gb+0L6HT/zopQ2XiOcmi8dYorYHAgVfIDBMN?=
 =?iso-8859-1?Q?uCYj3e0n3Ks3ZfTE1Vn1M8IVVHhydYEBEPBsJYyDZ4yOGS1MTDnyBJJQZi?=
 =?iso-8859-1?Q?YCt8zkSb7LFVap8LB5e7R5KoeI3ELAdhdL5uVhrfG5dWsBubeXmqgD72Ej?=
 =?iso-8859-1?Q?YO/nLlRgyKUdGO2OuexZTvDx1nC8/3oYm9Xg7LKbTzkBIVzBQCsdd0BRbD?=
 =?iso-8859-1?Q?ywV/RCQuX/wm9WO9Vh0aVCbCSn7RIfaUmfvHw9jXwIKSXV/s3h+JuBanbn?=
 =?iso-8859-1?Q?vMSWiX3jdkMeRRlEkM5k/sF/r3G4mv4AIs4UA+6vOP3DZ9XezqKtQ8FNRO?=
 =?iso-8859-1?Q?72bRz9Ru5pKn0UxtK40xg2+Aft2THypDmBybh13yHokg7n5h1LV88x5xRC?=
 =?iso-8859-1?Q?f8ar8Ws7g5ielzPeiwIQfS7CgTj66sIkzPoECqUqarGr7BlXTP5NX+/ey4?=
 =?iso-8859-1?Q?NaktaXI6kpvTCGhqvIc8qvQ4YXb7ooVhzj6WHhFkEYoEEyo5/cq0wnR6vR?=
 =?iso-8859-1?Q?69DLy2Gj1G6vGGQQUcCW2j8Vrk0lfQ9V14?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1ddfc4-3c79-46e9-fde8-08dcfe63941a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 13:04:41.9687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zUULpLsqRQAi8mFJkfnZGYTvX9w6R9q3Kk58uAhsdR/69ZX7UeSLQLQNBvk4qwQ3qx3l0FnFn5CA1BSqt59cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7080
X-OriginatorOrg: intel.com

> From: Orange Kao <orange@aiven.io>
> [...]
> Subject: [PATCH 3/3] EDAC/igen6: Allow setting edac_op_state
>=20
> Current implementation does not allow users to set edac_op_state. As a
> result, if a user needs to test different edac_op_state, they need to com=
pile
> the kernel.
>=20
> This commit accepts module parameter edac_op_state which makes it easier
> for users to test IBECC on their hardware.

An SoC's (with the IBECC feature) memory error reporting type=A0is determin=
ed.=20
Switching from NMI to Machine Check or vice versa for a given SoC is pointl=
ess
in the real world.

Additionally, the interrupt mode is preferred over the=A0polling mode unles=
s=20
the interrupt cannot work, as in the case you reported.

[ Sometimes, no choice is the best choice :-). ]

-Qiuxu

