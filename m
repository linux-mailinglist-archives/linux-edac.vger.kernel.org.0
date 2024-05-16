Return-Path: <linux-edac+bounces-1062-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D098C7D91
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2024 22:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1091C20A2F
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2024 20:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701F8157483;
	Thu, 16 May 2024 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WC8KMTpj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03928147C72;
	Thu, 16 May 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715889806; cv=fail; b=lcgo5Lp866TTi45uRV0BwWCSGL9LlBASqcW1/oO4P3G7u8r8bU94USxSEdVjhFvQPrlgHfPP4nllLigjjebJ2YsMFwOKK1fVjoz+wqyVIbTa507M96wylfP+/Pcj24Xt7HDTn8Mqr/EAHubltpo0PD49sUYOvrffy3Z5GjZu0o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715889806; c=relaxed/simple;
	bh=0fFpPVufTyrnTlpGV1SfoGt3+7mneRm57z+/55NsoL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WlTLMau00hCwBQtW0wt/GnOGVB1PltUFqKOPSFAsr6rr2ZKWZFlxwQoljl8EZ2JNQlfB9kVgUmblUROxhfbj+fv5y+1+c12JczIOitT/udF6EO/yYtF40EUGDdo46WYIeN9Owox4JAB7DsrOtkIpgOX0LkHfIqmsFklxt8b1fT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WC8KMTpj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715889804; x=1747425804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0fFpPVufTyrnTlpGV1SfoGt3+7mneRm57z+/55NsoL8=;
  b=WC8KMTpj9yOs8s5essuFL0w8y+WxFx5SyhNJWXdaEy6AgCUBXalt3C4f
   O7XWRSYIoa602vfEh1Nbauv8bHBX7Q6kXprBRLEL+O9RcbBOqz4Mh4tcN
   90GiGHTiJA9N1fCEM3yaqFc6NNAozzsqlwBZRtWu31XPPvy3jb5sQ8b9Q
   w/8XU4u9MESmGV9VqqzSrAVxGbaTl395qBhSbBYh5rzX2dgQ0GnzKYUDw
   lwHOcDvu0wr+4vnI2F7UUgh7XrFWrH/mqTwOwrUnsHfOghv2VwIjQaX1p
   TXVou2B4TZQhA95dzIXoIgtR9A6kFa48rXnpsFpYRHHQL3JHIPBkOer04
   g==;
X-CSE-ConnectionGUID: TksdX1/RRJuvR5SqG7YdDQ==
X-CSE-MsgGUID: Vs4rgT7tQzyyty4PrUfqng==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="29537690"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="29537690"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 13:03:23 -0700
X-CSE-ConnectionGUID: fs1rc51KQ26AKNcRNsMYUA==
X-CSE-MsgGUID: GxOZatTGQ+2mE/29lwMjCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="36335640"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 13:03:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 13:03:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 13:03:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 13:03:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTv+5UN0ug3JmipDW39orGCgSF9snBBNLzTBhEjZyolMcPHBGcfnwgF4BYNgC/Ij57SK8GNvOphn8IYbCLACP5nScu4I3fq+mnmDLMMdtVKGRvARXcef6x50QEhfgVbZMCH839hj/mHdXmRs9cwgQnEnTqPh4De6QmNkghU0rS/5SZmdzd/7db2AgKvMFbd2xjo4TyGmMhRVLJ8nM5Mp9eRK4zdruhxd4SOJOdvyzcwo+Bt4Vf7fopcEMvgtIe0dxB3MUg5NNA2uyLqb+aD1PD790gXS51ZMmsU5SDiaQREvEJFZKP08dHQM/NsIfvKmlRFcyqxW4BGNsIXc0yktSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fFpPVufTyrnTlpGV1SfoGt3+7mneRm57z+/55NsoL8=;
 b=eO1i284/JGvGjRHHHI+PeZy30Lwe6EcBAu1YFpPBmFbjUoI8qtgkrCiP/205pD4Ps0JyLMPeGfnMQH+CCljZ7xeTFj+ZuAZrQKw4G1Qo8k0PNAf3Eh51PcBmlIa78ngzwyJwBS6Z7kf+TTJUDwoJxbRlpB6izvfbIVlaHRFp+pQt52ltiQsclg/3i8zGXYat4K+p0bbdFUeIS/opkOyzcv/EJJfvHDsPGYSThCUVbb3LRDT0ueNuSBTsX/bEx3a+3ghE2u0d/dVHX/P9L7HUiRIxKaHIXAVdljGQuKZaIRtQTMfniojE6m1xEoOPUz9bnpM1kP3pNX3NcQyRbdJp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB7805.namprd11.prod.outlook.com (2603:10b6:8:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 20:03:18 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 20:03:18 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, Borislav Petkov
	<bp@alien8.de>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log
 unconditionally
Thread-Topic: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log
 unconditionally
Thread-Index: AQHaos06Hvj06zQ8zEub6wGZ+OrxmrGQbCgAgABm6QCAAAcXAIAAGJ6AgAAV8wCAAPotgIACRFcAgAViAwCAAJaZgIAAEY3Q
Date: Thu, 16 May 2024 20:03:18 +0000
Message-ID: <SJ1PR11MB608345327C015187C13A23D3FCED2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
 <7009544.jJDZkT8p0M@fdefranc-mobl3>
 <20240510192556.GDZj50xFIWSqK2gzQR@fat_crate.local>
 <2881368.Ex9A2HvPv6@fdefranc-mobl3>
 <663e9bd4c2525_db82d29451@dwillia2-xfh.jf.intel.com.notmuch>
 <20240511130801.GBZj9tsenZ5SKXgRTm@fat_crate.local>
 <6641548474088_3dce92942b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240516095714.GCZkXYeiKbUk2QXoIO@fat_crate.local>
 <664656cf7c59b_2c2629493@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <664656cf7c59b_2c2629493@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB7805:EE_
x-ms-office365-filtering-correlation-id: 494a8285-b4e4-48c5-7f36-08dc75e33ada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?I3KggomfO5Xgm9tLct97Pvwbrtr9x3jcdXrzH3wkFASmC8pmQFPWWUeFzBuU?=
 =?us-ascii?Q?Hc+VYPe8X3+p6evHtFpPFRN4vzsUIxQLv2PPStlxlHhiB02RrbliCtdpK/bm?=
 =?us-ascii?Q?FJNUUk08Od64E0/BTTiP85bNiFgEjF209d5nA1zp0k3+Ju5f2knanmyPJkHA?=
 =?us-ascii?Q?ozkls6uVVyhyUqRsmu9R6ClqJsgb6tFL5BomhBkNAdAJgU4dZCV37oNYpbJX?=
 =?us-ascii?Q?0WnAITnAvjat500y5WPJIrqyJzTMnE05pKw4o08m+2QCdxz6bP2m4aJVR9Ur?=
 =?us-ascii?Q?XTJf/cMKBq3QfU/27fcgtDFXVar8psBe9Ju+xVXB7yBK7VUtlzbh3A4H35mX?=
 =?us-ascii?Q?J6vPkD6yfL4E+HOB5g3PlzZJT+svtgy1sF9UTRg5Dmu7otpCeBeu58ZMojH7?=
 =?us-ascii?Q?4NXc3oAM2IoytqGl51fCRjk3Shcu8iDYPLd+ata6To+PlQOrwVAB3AUXuZ+3?=
 =?us-ascii?Q?SQ+hhg1Sz/kaSWZz9Wa+HM2vdYsiWbtl+iR24sl0VjCDTSRblI+fSnDo75L6?=
 =?us-ascii?Q?xZN3aLoTLN/sTotIJF5CHC/h/SGVjSsqYZxfW5tKjAds1pLr2KXu/bxeXTkv?=
 =?us-ascii?Q?AwAX8zJA3rV0gd0pvaCM3GOL0WJITiXBs6/EsSRDQMapMseucOtv3SWzSzhl?=
 =?us-ascii?Q?k8iP4pIpQ7aBdDv7JdnqLTXeO6xoaah0er8SekREWR6K7CcK3p9Mc4qlgxnT?=
 =?us-ascii?Q?5uMnE2eAJMhwBy3xKuMwq5nww9L3vEGI9MJ/SmI/blrWiEggSebQOU70DjPB?=
 =?us-ascii?Q?42E3ZNorI5DhdKelCNh4jtRTQ9ICqYoJUTQSCxi5o/hHqx55jdLgvPBpIXQj?=
 =?us-ascii?Q?kfxWg7KIFzgeA28gTzq5xVfOS0RGE7c5QFqn2KNCWLFisFBMK/8BJs2BLi8K?=
 =?us-ascii?Q?z0lM+NQHFKJ51UCvszoUma9AB4z57Oakr4M/p8nB6A76B2Lq/tk+erV4CT8c?=
 =?us-ascii?Q?YPnZbH2yEU4U9Cy7fu4CiqiIW1Oeqxwe+KB52bru+QABnEX5QL6d+IHB14cc?=
 =?us-ascii?Q?/Vu9hF43FcFDAFwW6Jb2vG8eP8tgjMTIFuRwuLf5gaZA8lqO3rlhFQdFty5Y?=
 =?us-ascii?Q?tqW+xHZXqV7HCWMDDmTZ2VIXIjSrONfgHSws8F0sC3/rKAhREN5zHTJ2o5bR?=
 =?us-ascii?Q?qam8pJE8wUZrWNK5Gj5s3SiziCMxwhQnt+vZd8NY++41uubc44R4UWXxN/xp?=
 =?us-ascii?Q?tudPQS17RdkFYKF7KlKBCSz07GMvImNv4pCYvTyVUTCMGtqYVl7OfSvAB/qx?=
 =?us-ascii?Q?Iwo8M91xER/j2XrwcVXPiRvCXBhFk+PxzDMRyVS1JahyiHWj+sY5eD+wIx49?=
 =?us-ascii?Q?ybe6pllvKvwle1QzsB+iCupIn5ufLod/iAajYcBxn2F35g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r5vlLYYqxMkoVaBFKuA/Ya23zgMDSdRdapjBo/wKuMgaw9BYrcsVIAh7CAsV?=
 =?us-ascii?Q?W6zLa9T8xHreEdcrRfl9e9GHXktOuLZKAH3IkjrZ7B+7O2I1fkzDSCaBl0Fe?=
 =?us-ascii?Q?4I3thsj91tbxBqEDwb08h5FBZSZ5IPfy4tuWaLjNdhxzPzZmP4SllxhtuSvr?=
 =?us-ascii?Q?dEz9rat8up/oKbeGiFZQ0MzmYb4tyu+AvP9bjWgmRz27BFM7w/Cc5jJ9xTFz?=
 =?us-ascii?Q?RmkymK3JGK+CyB35c+MxoXPD05XeXYj1DQkaW/sSU30O1UWyO2QGWQ17H8ih?=
 =?us-ascii?Q?axxy8QIB3oCtfkzT4TgnDifSQZcZoe+CPEGfQy/6R1HJhiBhDvSy9DsbKbyz?=
 =?us-ascii?Q?atvAMLQb4iQakfvmEdAKGMrf3iMTOiuOZ+Hf2lHyXysXWyd8L6fzm7YqD7y0?=
 =?us-ascii?Q?PNWK43/9yjtCyaYM371qWf5NnR6y0jMSwSPF0U8kjuNiVl5699jwyJdPdBrb?=
 =?us-ascii?Q?hhnseupauphZwM223S4S8OmKDsZB+ECY8N0Z7vJJgdD1/Qo81SBKq8359hZX?=
 =?us-ascii?Q?eE2G+hQHiLsZbu/V9HN5skG1dVIWgQ1PBbFxzvvG3sBT8j4FhHHWsaB+ijGe?=
 =?us-ascii?Q?LjnC2rWLOXPrSyNRiqN8VzGfskFOrzjYYcMXxcKmSWmn6+/LCXhZJh3GhMNE?=
 =?us-ascii?Q?IhQFRJhN0QkSD7IB11VmG7fgyGfjt8wQsTfyRoFJf+1icCa2Q00NNXXfgQ/3?=
 =?us-ascii?Q?4cNa3S/5+g0wfeL6jtjWSt5BUdPm62If69Z/hCaSWG9HkRKT6HQXCxCjTuqq?=
 =?us-ascii?Q?QYuB8uJ8OPsp+AKSX9wZUxMz/i9V4q4V2la2MA3ajG3Zo5VKtoK3lH9i3hrJ?=
 =?us-ascii?Q?HpGByF41exWZ/J9Di/Yo8XILinPffbXoSGA4MQbVhr2CnXJDNwO8EfOYOSd8?=
 =?us-ascii?Q?iWhHSe//rIRacYDLyvCYp2VM2BDb2WkwuvPZjevAW5kY590EHjuw1CwcsqD5?=
 =?us-ascii?Q?pAIxDeAY67RFVXeQDxNoCI05Ls4Qf++4l4nDmfxa++KvfvQbru4llskwr2/K?=
 =?us-ascii?Q?Mq+QnsWBmi1EdPcenbWJv5ptjNW8JZuOMIjMdTLGMAKQx8Y4CKlf6namd9XR?=
 =?us-ascii?Q?AAVNdZY/+V0WMgcfUZrx/M7gQfWSs0Upmqvdr2QphVsPJDheun6knmS28vmW?=
 =?us-ascii?Q?HHgf0glMxs1OdPXg7O2O5VdtniMJn0KCuRofNU909IyBuF1g/npDy4k85E41?=
 =?us-ascii?Q?UMURRUeblNw3atHX5xw624aeVs3MXDsi6SwAmT5hG4hLn9a155t6+SVz/d7N?=
 =?us-ascii?Q?JXryvz+kfsvxL6k1K/JULg8RXUGIsYaKm6k6iYdu6ZEqkuw7xmAC0NNa1TBj?=
 =?us-ascii?Q?ypgkjrcHV3Bfps4UaZNQPxvU5OUMGVbkZpB+r6IXYDkr/ezNlpOLjr7P0eDX?=
 =?us-ascii?Q?6WKDEiV+dCXWvfazXTTxtVRgtZ6tfMVdjgVzDFEeDudxo9mpmEA56H2whrA/?=
 =?us-ascii?Q?q5pegrG+Fgw4CLzxDqqnpoND/owZUYdHzamZQGR4rl0VMHVt9ibslYVC92kg?=
 =?us-ascii?Q?/H/yid6olvbwbLPhmehdgXzN4Mp5JTJCVmsuIADQrHKWuvFaaeNZ2i8AZ8y6?=
 =?us-ascii?Q?Oh9P2+/dVF31yiB779DLyuWjXX4hJ6llEkc+GLxO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 494a8285-b4e4-48c5-7f36-08dc75e33ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 20:03:18.5169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6N4LWM2XtXNnv86kZwrIeswws8tPq2x7gIA0Gc2IYrnD8nQYyXhHfSyrKmrwXltqJBLHxdYEuQyGXnIp10JZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7805
X-OriginatorOrg: intel.com

> Given that is has not kept pace the next question is whether the kernel
> should bother to maintain the contract =3D> "if nothing is watching
> tracepoints some subset (all?) hardware error messages will be reflected
> to the kernel log".

I'm with you for corrected & recoverable errors. The console is a terrible
place for those logs.

But it's handy to have fatal errors go to the console. They may make it out=
 to a
serial port, or be stashed in pstore for later retrieval. Trace event logs =
that
are handled by some user level daemon are just going to disappear in a
puff of reset smoke.

-Tony

