Return-Path: <linux-edac+bounces-4017-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5CDAC6A2D
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EB91676F9
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 13:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A972882A2;
	Wed, 28 May 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTkqyETI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE02874FA
	for <linux-edac@vger.kernel.org>; Wed, 28 May 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438266; cv=fail; b=ISALv47FtG9mYFbUsbLeAbyApj+wP1I4ksyWlhn6r4JvSQApAE9zJRBykAcJ0aCdVi6jp/RjxVSBv/EAG4EzhskGveumk65rADdIYSnedsDu+LdDwShLEO6WrwKh/Ce9b9tCroF/DktVD4TVFww3DBZSzyRS8RLOL5Dp3nOj9/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438266; c=relaxed/simple;
	bh=vZwL2OGOF4IrBChSRSL9uiLd8eiPWHX5nxIki8wBipQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XN4ALRjl1NOOX+TZqaEDgP7wemKpDggxl1AW+sTOMWyd9kR5uYJkzErcZNn50OpYJqf/zqi27A6+Du0ShjzOsJxc6Pj1QHJ93Hj7CR/ehCGL7Eb8vq6QAkQSg4m6Xa87wgmym6FBObXA9akXpKHFj5Tb4rcfnGUrT6OPHft5DRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTkqyETI; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748438265; x=1779974265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vZwL2OGOF4IrBChSRSL9uiLd8eiPWHX5nxIki8wBipQ=;
  b=UTkqyETIKSKhA7TrpHVVbQBesSr3HT3AEg/fHXlCYqGXCFkZHT/52BwJ
   9QECZucL3vl/mYaP2gdV7W/g8gv17doHk6Q9eYBYw52UrzxTU9tbdVEo7
   TII6i1msDQFcDNZXafuRRT/KgBYRBwIkpqmr7apsc3mhz7TB6ip2idjf4
   XVFAM3b1AY55WVeF/hC7zm/Ems6eOS0PstNPa1NatzVOGvRKHPYqXoeR+
   8QB2NE0Ut7zuDCYITmhdwzbzCIz+cn+nte7LK634m2skWka9d+/l1YxnL
   ZdA+K0n2h141Yz9+OnexvMwtc0iTUlAzsFpnQjztAyhPChoXLz/VlnaEk
   w==;
X-CSE-ConnectionGUID: R/JAO6q1SxuwCVKqoXCALQ==
X-CSE-MsgGUID: 8rE3WVn1QLO6zKn96mUX+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="75852005"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="75852005"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 06:17:44 -0700
X-CSE-ConnectionGUID: 73gK/9TmQhSkWPirTrrwuA==
X-CSE-MsgGUID: VQ5ZEV44Smuv2q3n7giMKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="143226831"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 06:17:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 06:17:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 06:17:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.40)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 06:17:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/hMD4uodLB09FV95sozbRvt+WpcBZNmfZfz0R5hWSHjVoo5wZRYwHQCMuJ2SLKhNAXJ2RnWX9YZKNFdE3agN/d022Ko6cJLi35jeA4lKp7RPcoEIfXk4dFQJmmN4mic2L4VRJ8oQNzoEQnrUmj8oy5V5HCJ9G/A4NKYJJ9NzXlI2xigPjUFh3jeHKD69g2z/slZxKqvIdbes2r/+vP2iOp9T5lqsBzNn9NnfaLeI7CzoaKJdF7/T/mzGDzB2k7sRrkSnmhafHxGBRLDfbH5c2P+GadXgCDoHb239j1iERQsF/yMmKLamruJeygIv8Gf0S4cBwW1fLus3+8e1SKM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJC+K0cSXfqs/90KtNwFF6IelUXy4MEUD86UzGvyF8k=;
 b=b16zmiJHVxxgRi/31Ki4WpdGUx2XyJ5B0wAOkHX4ZIfIs+uytcXYkv9WokrzeOvCF9+zp1WJqfS6O+MVaq5ihSxOxkl/JVEFz9J6TkvHdUWD2dBZY1MtxMaefvOZUPy5kkmH7SXmqjvWeMrtx4vdMoPK8oqAoJWs/Q8obWS+r+ryjkkrGeo5qBIwtQB+iMYDqXWu217ptKnWwoolc3b2IM/Zkedp4Wk/Tpt95P2hZCdz+FONZz86SVyslwVbo53Dq+8d3HvVVL2Rv4Pp3En3KbOXtcIvILLDIEhHct4Xo84Bke90GM3XeCGzXKVYK2qNzPrMF8FUj94Oanr1dvK+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS0PR11MB7788.namprd11.prod.outlook.com (2603:10b6:8:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Wed, 28 May
 2025 13:17:40 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 13:17:40 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Rex Nie <rex.nie@jaguarmicro.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>,
	"hunter.he@jaguarmicro.com" <hunter.he@jaguarmicro.com>
Subject: RE: [PATCH mce-test] thugetlb: fix test case failure due to incorrect
 getopt_long() return handling
Thread-Topic: [PATCH mce-test] thugetlb: fix test case failure due to
 incorrect getopt_long() return handling
Thread-Index: AQHbz46pHn1GtlXp/kKKMmTIY+qM+7PoBmOQ
Date: Wed, 28 May 2025 13:17:40 +0000
Message-ID: <CY8PR11MB7134D229EC106D6E414EBF5D8967A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250528050705.409-1-rex.nie@jaguarmicro.com>
In-Reply-To: <20250528050705.409-1-rex.nie@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS0PR11MB7788:EE_
x-ms-office365-filtering-correlation-id: 6f57690f-95cb-495c-16d8-08dd9dea0621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9oZ24FxUxJ4GDPLeUmNNte7F+LCY/Jl9nrqj+M4YjVq/d5lBM2zfPUxj/0YD?=
 =?us-ascii?Q?QO4g5BACOeExweL/3kmunlqRhBXneXgWnNEH3RU1TcXoeQ3nZKg/8fZDYwPh?=
 =?us-ascii?Q?EzXnjlbx7kILtgdCTQx2VJpwOgxAXzgfu8AKi9oqLk3c9MYl/IbBHzGi0dZK?=
 =?us-ascii?Q?zSwfRqxjiAwh8DxKNR43krsekHC83UtlqpijAEOpTosIGrVcxucnOvuIeE1l?=
 =?us-ascii?Q?Cbs5PThapNfXi8Q64E6FAbrENIgP4byxUUTq5UMy19QTn0aH15KxpY3fAPpq?=
 =?us-ascii?Q?tLuxNzW9S6ZBY157lUqpSMFK8oQbdoQR693HqREkztp5EmMN3B/waC21sYH5?=
 =?us-ascii?Q?F+UiliqYLzqii9uuyBmz+zufZH5LgLSyLdhWaUvydtgZ/yGyGrrhAkv+8z5W?=
 =?us-ascii?Q?adkwCr2L0tQEFHiIoZ97N1jpn9e0swz6UlLouo0kl9g2FJfIW25K8t8KILiJ?=
 =?us-ascii?Q?ird94E1Qlw7uiAE8BzYXPems0XLglbNiObqcBsLHzZ6s/6/qCYpk9m5MU4HH?=
 =?us-ascii?Q?0RmJlppQw0nUVDzqanXfw0l5ZiDKtG95KeDicR86p1lg2opzYHuYFEah/t02?=
 =?us-ascii?Q?ha6woykTVOspcDEK7x18PoyWRDZMMfnFyHD1y5EyjMVfOXr3ZXNgRPRG/wNB?=
 =?us-ascii?Q?kJZXLUVsVGn7GvoU8Lfbr+T/7F/BZ9JvDBZ1zi8omXI4etgjSb/8pa7IT7E6?=
 =?us-ascii?Q?sFcflU/kjSv60K6di3SxpTy/zW7LQQ2ISLFFNkqx5UHIUkOkdolZJGb7iMVq?=
 =?us-ascii?Q?TsHdiv8VD/9Ol0rOSovWuqFISFeyS6vJBPovAX3K8vVfAVTRM2sWa4BKeooS?=
 =?us-ascii?Q?URKSHA4F0METzQbGjBBpS9jN8KHqwOQhEwAQ/V9uDvZV8kYK0O1BjEPbTCPu?=
 =?us-ascii?Q?ox6hsUnx8IcgeITEJILDK3JajhLU7RIWtNJhtxc24jNd1PG8+tmWhC6mbTG5?=
 =?us-ascii?Q?SnruMFOQcZJzPaTBv6MuDyhm8iiPG4F3ScY5yRTiE6arn+aixtGRkvfxLSLB?=
 =?us-ascii?Q?/j6IRYpyVJ6AXX4ByQ5WIzpqNhd4R+W3uKSYO2LYZ8dd7ZQUCIhF+Qw7ilNq?=
 =?us-ascii?Q?rOm9y99iEHCWA86O8mNc8bx3KY9DMjCptVbCvcvxrrSlTMT+HRxWSI3CYmyV?=
 =?us-ascii?Q?bHnRIogJxMBV1VCPVEpw0RaF37bN7eHWcTpZmIRVjU+FiMolCIJE52KtfrPz?=
 =?us-ascii?Q?RK/QyNY4+ri7PSRht65jHb7yhD/tH7OlNDe0udPPwPyPNelUxZhU7Pkp52j0?=
 =?us-ascii?Q?1F8NJvzsR4q6VugSntZJjIzV7EpjPXi/og/GcEGN8ZxSgjuVm/5g6K6psD2P?=
 =?us-ascii?Q?l4UfL/BSKZKfkxfiqs5bUhBE20nkz6ZkHjKeQia6toW+VNgFzWtC2i45CkC4?=
 =?us-ascii?Q?4A65J5wxeIYgVEw8nCMHTfjNLjWVEIkQwYcVnTzW5n5jXcU5cY296hZJ4sku?=
 =?us-ascii?Q?Hkx8G1sc4qUWj6YIMpBo5bkRIn95RdF/7TmWPvPXWra4Yk8uLqrsNQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZCC9HQRSAYvqqUQOBU2/7YWqehzeNfrov3YlSMSazVg+MIzq+ckDkbNAwYRZ?=
 =?us-ascii?Q?3nEOBRgGQSGi47SNhaFtAhm5YaNUO5UPUcPRs1stTKVDL7484NMSF7xLUhW3?=
 =?us-ascii?Q?flak9igSrmVoTYzyPzAUK1ez9I1LuN0hAMMolsYVXdw8tU+hc5rSWahNI+E+?=
 =?us-ascii?Q?nPHj3hoqutKrNdLpvm7Zv537GPEzRgEM3sAaUXyJZxu8Unpekymt62bagbcQ?=
 =?us-ascii?Q?ZZqFDHmifd2Lvr0q8QuIH0ak0rA/KjB+0SjzGqU4YPXpeIRCOj8w6uFLppb5?=
 =?us-ascii?Q?LSA7egH/4gC0qJiBMxOkZizaq/txvS6w3ExC/yutQVYiyomAHGmUY1jXKtjB?=
 =?us-ascii?Q?xuV4o7PxJH6Vr+f62NbOZTL7Kn44YSinsQiVB04/z9u1Zk9AyOvgaC/Z0Y/C?=
 =?us-ascii?Q?bHleClPQFMK+usIcjuSQPX48UVvBJItAoswu1NY/ZmUM8au/hbBbc+0cu+n6?=
 =?us-ascii?Q?j235bwGZAKDMtAU2jCrQfCbZ1sQSZVtpznUC5brpQVbZ6Nb6n8Yc1+mOhr2y?=
 =?us-ascii?Q?/nuf/bLOD8nLhvj1KjiPiav+TXQ70lnCPw63sQi9jg0XnHfBI+Abtv0//EgC?=
 =?us-ascii?Q?7WFiFQsM3re4CeYoSIi5gQ4oTbadk00ApyQ2M7zmlyaTsLsRh3w0yQg1XVFA?=
 =?us-ascii?Q?lCfabVMyCpXVbR5enLtPdWyXrrpeXcwLh4CwywnCgsGdm7974a2TRiy0ghuV?=
 =?us-ascii?Q?/hxLmBEN1mCKyw6kM+HrrFX7+r7/AyaMbXNYG9etY+ney+A6noYwswkZdVVC?=
 =?us-ascii?Q?5y66FZ9BPHSS2jTKFDRHshiD5xwnQWtgKOXBPDFQ+s66clB3uUtRKBq7IJvP?=
 =?us-ascii?Q?vMXwl5lNFS3mjlgX34+2j8EivEFrUa+cFg7hU+ipzShFr9K/gy2bSpPltX4i?=
 =?us-ascii?Q?K+wp9lX+lJtClyw+qG5M4E8h5X5EcL4/gBhY+pfq0o4T7nk9gRU8tuhO9+5L?=
 =?us-ascii?Q?ehczMnhwU/LY8yhP0tpjnF8oEgvsV0STWPNDNb2dm0zBfMPB+3WGHlr688Ou?=
 =?us-ascii?Q?DWlFj024zxVftR9NJ4fg1paIidW+hE3T0p4Y0anJQ+ZOn6zOlun8RRxGj3lX?=
 =?us-ascii?Q?TpLbx1qw4oAnY+pQe3rtcts3v8OjQc5nVnYZ89OKlLN8yJ8yXh8alOBYRaL/?=
 =?us-ascii?Q?yZaOG01VnIvdw8aDeZ6kLB5ZW6kb8Kq3I1yqykG0X40dt60q7KGn3MGjtHBA?=
 =?us-ascii?Q?eMLEGT329Mmau0YhlNXw3XPw8+vDAV22UraAdOdUU+GeOsQwdZJ3Kd5sn6Av?=
 =?us-ascii?Q?ocfEQbYPurhhEmw0+mlXJ1oJlsA3UgeAu7UVYPBctIV2y1HweHSsoOiLW9XZ?=
 =?us-ascii?Q?VezT/LFvogFy77Qnt1um9ZdI0NqTwUTqrttxi1YtJI/riOhq1JRA4K+0TTJb?=
 =?us-ascii?Q?5c9RyyKfUcmpP2xJdzK4P5p3EWicTJY6pV2BAjcOlOuGFEYSeSGEXtnc/L6K?=
 =?us-ascii?Q?wUDHayLxt23p30xHvljebXEHywH8xlT2/B5hXzDl/ycEb4B53oGUTUTKjXLi?=
 =?us-ascii?Q?HRWD5jndhLehsjRbTol66Y0gQvGFNPSe9HfuyPzDiL6MZfP5i4OQitgzEthd?=
 =?us-ascii?Q?JIyHmn30RY+8SAsf3VrNcSwRK7eHK3xzSlYaE/bI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f57690f-95cb-495c-16d8-08dd9dea0621
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 13:17:40.6824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbpaIMLB4vkhi9TqPfbH0ibx7PALgytDLYIKUak59AQYjoO6uemCz1wiHxUtOMZrqVppz/lJDAkDxWtMBtThuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7788
X-OriginatorOrg: intel.com

> From: Rex Nie <rex.nie@jaguarmicro.com>
> Sent: Wednesday, May 28, 2025 1:07 PM
> To: linux-edac@vger.kernel.org; ak@linux.intel.com; Luck, Tony
> <tony.luck@intel.com>
> Cc: angus.chen@jaguarmicro.com; hunter.he@jaguarmicro.com; Rex Nie
> <rex.nie@jaguarmicro.com>
> Subject: [PATCH mce-test] thugetlb: fix test case failure due to incorrec=
t
> getopt_long() return handling
>=20
> getopt_long() returns an int, not a char. When all command-line options a=
re
> parsed, it returns -1. Assigning this value to a char causes incorrect be=
havior
> and falls through to the default case unintentionally. This patch changes=
 the
> type of variable c from char to int to handle the return value of getopt_=
long()
> correctly and fix the test case execution failure.
>=20
> error messge:
> -------------------------------------
> TestCase head early file fork_shared killed ./thugetlb -x -m 2 -o 512 -e =
-f 1 -
> F ../../../work/hugepage ./thugetlb [-m memory] [-o offset] [-f file] [-
> xOeSAaFpch] hugetlbfs_directory
>             -m|--memory size(hugepage unit)    Size of hugetlbfs file
>             -o|--offset offset(page unit)      Position of error injectio=
n
>             -x|--inject                        Error injection switch
>             -O|--offline                       Soft offline switch
>             -e|--early-kill                    Set PR_MCE_KILL_EARLY
>             -S|--shm                           Use shmem with SHM_HUGETLB
>             -A|--anonymous                     Use MAP_ANONYMOUS
>             -a|--avoid-touch                   Avoid touching error page
>             -F|--fork
>             -p|--private
>             -c|--cow
>             -f|--filename string
>             -h|--help
>=20
> thugetlb was killed.
> PASS
> ...
>=20
> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>

LGTM. Thanks.

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

