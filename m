Return-Path: <linux-edac+bounces-3192-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C4A420CC
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 14:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B243B96C2
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 13:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0324EF73;
	Mon, 24 Feb 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ilTV5/0O"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923624EF62;
	Mon, 24 Feb 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403885; cv=fail; b=pR5M1zBVTErLqGRQfdLYPsq9ZFFKS1VXlZ/5sZr08+DE3GSVBcbsyCegWjXnaakIAPrNM6JxWMzsh7e08mY8FNi0hrK+fkmMO1bdjQJsj5QCZ+m0xMDNnQiNf+ilPdDFBi1Zt9z0KcbGAK+Sh4mv2w21EoJDfn18WodXO8fSbOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403885; c=relaxed/simple;
	bh=dvMELv+Y8C3ds3xsWU1ou6QbAc4CnZpH6z474fWLFYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rtHahMRHF61pfSUS5alZ3zf7Xg1bUGmJISPWD0AOBWxBEhVP5U9GsKtnF33D7ZRTMdR7TbYS8i78rIOheSdzLf6i5ne82oJzGCQlCZp3xPxFUrAQiOlrDIEXWnsrEZ2TUGawMjpEMohm2r5bpA0OAuhriVsoV3Zqy1oUHbXNbak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ilTV5/0O; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740403883; x=1771939883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dvMELv+Y8C3ds3xsWU1ou6QbAc4CnZpH6z474fWLFYs=;
  b=ilTV5/0OtW913I7f7vwJud5g+EiXqgHDd+aC+4Q5wy7b4LuKKXjCj4ep
   8uOXMZQQkKxCFY0A0czUpfpRQElccFLPHoBDBYk6gxHo3x4Vj6fLFdnox
   sDa8W0Xz1dc5NJkKgwSftUpQBcICyjgODLqcCHzanc2lVetigfwgoyJ2I
   JwY/hy0hN/dzR9FhEeHo2DlRBCRjCJ7gkferiNgDE7/FQT7YaCSVIAQ4z
   +o9dpZimgQW1Ak9uhgfjcmwzwxXE5tX5h1r6BnroExVW1KlnekGqewwEw
   QFphtyiFyyJrZFF7LhgU1o6Ll8LyqPLf8tjiSP/BLG36hzpdGXA7zo7ey
   A==;
X-CSE-ConnectionGUID: mp7lDaQwS5GrA34nkCTVpA==
X-CSE-MsgGUID: JHuzAX6ZQnuvM//pyET3wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41275199"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41275199"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 05:31:23 -0800
X-CSE-ConnectionGUID: 4y+/zziMQrCquds/UP0Kbw==
X-CSE-MsgGUID: 0+Id7pcbT7mcUMYnjx3ADw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="121155357"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 05:31:22 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 05:31:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 05:31:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 05:31:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxzj2tCOahXYVCjurJmLP6rwwqGodgw62sL/dnnhOhutdORDkXY3hx+ARRK8ksS0QrUIVkip7WHj6eVx1GKg/fGtTMLb2AxeSF0P/NnbRGHPwDhTEVRLjeI6roRLy7KXh+zKSnWNzzHJQASZ3dPcmSoLFz7DuhvOSNUue6udU8g67KyfmG9whEuoOUJXyOJ71nyBlvchifpnZoBZhiwMwbFcbuq1PRL3ftxgVjyJJNBD8VVi1d9webx22Mgu3ZjRQpCrOmSucE/gxqmjkrZU+lccTtCcgY403OZbE9sI3srnUZTgwbu6dSwMqxFwQjn/T/htzmPXxf3BqqCZf+2dPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jhU4pma29KExFRMuJY6QXsRj+4wUPhKGAi/g1YEcEI=;
 b=nhsiofoC+FNgo6CjAKKTQGfGy5TBcMcY0QYH3tg3coHjEHVAMvhrRn8iWIlGKoyileBfMEhFj9oVqetTMiW/lRGMGsMASGgA7D+rB+fsD8hg+P/HqU8V1KEvhBn91NlHsW3V46uL7VAYuF5GZEewp7++0sHXBuYyaSgt07To9lDgyof/wQK2F60FwaWkwZmE/VqV3goFwkQRcyLeg3r571ux+eCDOFXjHsgrUCcpZBHhoMaQUu1A7XBQo5MsScR9RafMs/uUUTMPmNbekO95l2BmqE/p7pchhdN9ePYA/1ElxIDG7mAhLYf55319pnvlQ2BDLBXMZr9JVrPQGjeoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS7PR11MB8855.namprd11.prod.outlook.com (2603:10b6:8:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 13:31:01 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 13:31:01 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 13/16] x86/mce: Unify AMD DFR handler with MCA Polling
Thread-Topic: [PATCH v2 13/16] x86/mce: Unify AMD DFR handler with MCA Polling
Thread-Index: AQHbfjgoQWs/bRLHLkmM5J8oXwf5nbNMsZTQgAIjSwCAAJ9a4IAA2kKAgAY1ZQA=
Date: Mon, 24 Feb 2025 13:31:00 +0000
Message-ID: <CY8PR11MB713493E48B5B09225DB5EA5F89C02@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-13-3636547fe05f@amd.com>
 <CY8PR11MB7134EE8E03532382B8FC23F389FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20250219160930.GF337534@yaz-khff2.amd.com>
 <CY8PR11MB7134D8A672FE9F10305546DB89C42@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20250220144101.GD589698@yaz-khff2.amd.com>
In-Reply-To: <20250220144101.GD589698@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS7PR11MB8855:EE_
x-ms-office365-filtering-correlation-id: 1e27de53-7bac-4641-c54f-08dd54d77ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XindSYuwz7WWo9c8xginvkHp9buTsxWQuh24gIKV8HWXvKhDTpMo8/7ajKe2?=
 =?us-ascii?Q?U+1LT5015Dh+B4uHxBMa+463WE/3QW+QSnDrFr1hmtM/zCyx7NjXBwTUvD3S?=
 =?us-ascii?Q?AsLp3d9eZnkJtyGsShjWgg4loCZh5AJ04/RgLk+I96CqrKQq+8qEfJQtFZto?=
 =?us-ascii?Q?AyhlcB1FcSMxweeiqzH8J41nL5dsb9XpmryaJrEg0JqP9JoB81BVoppkNab2?=
 =?us-ascii?Q?eU/2Kdlb/xgQeTkymquw/XqNojBAEroCVLCBzVUFVlnx9E2YZYGb67Ic82oS?=
 =?us-ascii?Q?GJBaS0wfLqHgsX/I/2KgH9laKX1e6+PDglhVWviz8Aqhc6j5UL+PUvI3QTU5?=
 =?us-ascii?Q?aG9YUzp5FxWGa+ywyC09ZE2dW3cNtA+qhKzh7Qvl7MPH9zYXKraXJ5LFQQ92?=
 =?us-ascii?Q?4TKeqCswdH6XVu0j/1Ywo6bu4p3uc4vx6iaLkKU4t7cjcVzjRd7vL/nRL7NZ?=
 =?us-ascii?Q?kpug3EQQEeYDnNAqlI2VWK9EVcJ3Js4Wipu5EPs0/V0y/UhZKIHGIOMoHRxF?=
 =?us-ascii?Q?dSiVUC4TEo7x7k+FZPIsTzdlGjhzl1KZoONwvS/vc8R30w/XP+qyA6nPhSVV?=
 =?us-ascii?Q?DKMEr88LcaYm610+njf8zJ29NbMD9ZGS2rGtL6J3cvsy3uOafpDp1Blbw5E0?=
 =?us-ascii?Q?vctAdGU5labdTCoz6BwWSGM+rpoBawF0zuGNyqiMqIj6o9fFq1V0qWvNS3TW?=
 =?us-ascii?Q?nbA5GAd3JLSq0eI7nBvdWO+3ptQ9+Cp1LB6jEy2wTMwixIB/MY3pHeZecpLk?=
 =?us-ascii?Q?yFgPi4j0lILXcH62Q69jkYnFQ9NF7A/+j+tzafbQZX1/TXnB2azO0EfAoZDF?=
 =?us-ascii?Q?ZebOX26SUKolhDqhbcGmebPNJbeVIEFWLxC2QytNWYPvWFIwvbiebHf2J5sN?=
 =?us-ascii?Q?hTzQKwZaJgbju9PyWqTzEty8U0Bpp4KDA4kclcaDaUviRxDbN900qWm3c/rc?=
 =?us-ascii?Q?iLpji6QN9KZY/hcjwAe5T/a06kMp4aIhaN0Px1aI+jiqMI0PXgbwj10QiQOS?=
 =?us-ascii?Q?kyZbk3+TylcE2RDoZgxk8TKeKH9p4QDMw26cIuqOL0BINnDyFCN2yKd8GnQT?=
 =?us-ascii?Q?gPT7TPz0ZL1J5lhacnp6GynI3+MLvz0sbJprZcYCEO4NEQF9eMftpj5/RHZa?=
 =?us-ascii?Q?3v0SnFXuezVLOds31B9r87MC+rWn4AQVzg0SagkbgFYP6X3EJmKnskRtvid1?=
 =?us-ascii?Q?8v8PU6IPFP6MSlpZLFTr+O7ADGYnItS13b+AyD10F++V3l+gvQTA8YZADi1J?=
 =?us-ascii?Q?DyYJ7IwR0IxWJPFIon5RERm+ad+RNAkO23yqV9yN0dkisYyQkLB9mfN8yETo?=
 =?us-ascii?Q?aRg2gB+hBy/IT2FVwTC6AbTdrP2iNqc11N+jPFMfQPEcAouJsU+aXOGKeAFs?=
 =?us-ascii?Q?SFL8Xu0n/iMtAOh/Vdbb7WAZ7q2MsCquMHMY8p4viIF7I3Jz/lFxveyH2v2X?=
 =?us-ascii?Q?RGhWCVQybjIUiC9aeafhEgzpa7WM3KH7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qpgdRvxP4x6j9sBv07msXV9iNkF6A7fc4MelrXsYPAX4VjdvSprtCA2lHLf7?=
 =?us-ascii?Q?xnTpdOiMNY6BHrH0rrS3p+PB4wgSaM9n03+2j8AcjV2h6cxUSOD86yjhCdgS?=
 =?us-ascii?Q?1ICGsTk2yRnWgWpu5Cpr+OXrmoevr7PG1h3tS/Feu6+fH8XbwwMl40PZz2wR?=
 =?us-ascii?Q?y2ZDXleECYQ127y5RxIj8jpj7wuQsyzaC3N0YeHSZ2vjZTQd4MyWxrEdukUk?=
 =?us-ascii?Q?PH1juzZ4dCvmJhD0rpxbLbt21kCQHZlZNCibJA4yhCSf4gc5UE5LhYXK8pHI?=
 =?us-ascii?Q?VNwqrZMgbdOPxmVE7WcOIx4dEyk3Mb5eXa3KvyKwUO8Tw55b7+tCoPAnDiov?=
 =?us-ascii?Q?BQMvuWhWkQnvvxYAJx9M4hJXzXEPjAeRpXmu6RAwemW4V5T/wEK5mntrBFmL?=
 =?us-ascii?Q?Um/tFO/hQ8oKPT/Xdz7aAv03vrvmSJXUlUKedqyOj/UZNccaApe66861PwHe?=
 =?us-ascii?Q?HbS6ydcoV+8KcrQeuR1j+W1AuaihenImZ7i9+MTeIg1AfVpdV6GBwLRDGunE?=
 =?us-ascii?Q?nNhpEnfzR2uSQzEafYf9So98DwWC5qWwDACE+C8jws4Vk+VZQP/kWkro9PKf?=
 =?us-ascii?Q?vPTWWWRvr05J5e7z/cgAlLUtnWqRbeUFDim8AHGwJAvcA34q63TOyqNWwSU5?=
 =?us-ascii?Q?fBbS3CYDllL7TDL0my0k/gJCxA1l31hVS1f3UTdCj6nl65f5qHRJDjiynRyH?=
 =?us-ascii?Q?dlC6OH4qwdk/MAmT16NKsDHhfBNozbbWq01wfATyTRk+XRpkJCxAl4RmpSBJ?=
 =?us-ascii?Q?YkGvo/MUh8bFTPrV1fBS9N5lcicMDVJJrvorR6xsT1sIL5gupldUr2DpsYcG?=
 =?us-ascii?Q?zMfu6WgYodnAdGS/0lERCXG1ECWUSE1S72x1gSU8u2BwdS+Qae52EwSbEkdO?=
 =?us-ascii?Q?VaqMnsyHP56iYNW1kZnE8Jm3sGM7rROSypu6qeOH+tcTBeHfFVJMaWeFWTpJ?=
 =?us-ascii?Q?T0r+u9GVCP8xcXcrDXVoByIyibOj/vXQUYV69BsuadTP6uKYKd2XOY2753z4?=
 =?us-ascii?Q?gLTDWAdY/4qJ6YznYcac4SY8+o3cUVQllJo1W4nemTdFVlnrJaBIXob1ctOv?=
 =?us-ascii?Q?EqsQnfjtC00/fcT8ufO2b6SkD50/6bMWAJM9gAwlFEalTZvleKe91U8APqsn?=
 =?us-ascii?Q?hj+v3aedF92c8DVHdRxmGH6YrZIi/WIbMsNzmkVuEIVGvHSGVyG9DfGEo6Qm?=
 =?us-ascii?Q?g5AZ5hPfjFufBi4QLxYXpqvc9y08QBVukx2AclLGQMfPZdPWqRk/hjM8ZIRP?=
 =?us-ascii?Q?1VYUot8rZgk3YUaAol5h6H/6K6GTD1/Q6hoXyi3JVrA8sMB35rsBEe7mYCFZ?=
 =?us-ascii?Q?YFJ9tjvVt2vK6cimjGNyO1zXJbfe5X+Bhmwuaey7GEe/Xf5vudamMxh3jSYR?=
 =?us-ascii?Q?N3x3/LhcTOwfwWm3qaQraUYdfZmlFK2gMj4b0Q5c0mSRoYfjNVBWpknlOT+z?=
 =?us-ascii?Q?nrHnTgOaK3jtAsGqoUR63BPOqiRbtXO/segGB52p9DmmP0pYvSKQwCrOzXeJ?=
 =?us-ascii?Q?U8G3LQxggiICx6ZZZVKhKU5/UgeIKokbpWOO4YasOaYOz5cFDRbDJ2Dt08ey?=
 =?us-ascii?Q?Z+AI73nsr+4VVcrheMGVfWWmK4gcOdrBsVqTa8Gk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e27de53-7bac-4641-c54f-08dd54d77ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 13:31:00.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flDEoEVaoVEh1ACc+7acq58NfdVKqtxdpTHhs4EsiltLzXtx3YZUqEtujPnt/ugitKgKxAzC83KPs1TScqnyDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8855
X-OriginatorOrg: intel.com

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> [...]
> > Thanks for the explanation.
> > How about the 2nd check "mce_usable_address(m)"?
> >
>=20
> It's not relevant. We want to always log deferred errors since they are
> uncorrectable.

Thanks for the explanation. The patch looks good to me.

   Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

