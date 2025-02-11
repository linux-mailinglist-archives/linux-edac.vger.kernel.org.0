Return-Path: <linux-edac+bounces-3018-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040F1A30430
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 08:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94251160744
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AC61E9B2C;
	Tue, 11 Feb 2025 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fht0C3j8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0532D1E9B24;
	Tue, 11 Feb 2025 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739257825; cv=fail; b=jtlvQcRrw26ys13jzr8QdpKVhDVH2h3/CaKZiWqRln2SzPlDluK/68wOj6ADkMHVL0U0iw/yfKxZWKQsrC4ojkENO1jUwt3ooNkBhZYJrY+ROW7wTohhB3dHBQSuq63w1hOAB0afjYg0Pa50ylAp8FH2YIoqmlzbZ9lkYuDG9P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739257825; c=relaxed/simple;
	bh=F9iZ/hg5V9xXtSF6Ml/G7w4ioLmk3Il++H00jxFw/Z0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SW6tgcbbI7Fg4Hwfj2Hb43Tn9ne8UQ3YQ465p1uUlHwmhMREU5Ov0eNQPKeFdGD1R4n6EIE+iIDozQ/d0kDyk/3fh3Hv2qn9745sU4GRYB+FP1gwMxLGuLe/pMpdXaAh6yJ1AbASUmJ6pTEdlrNWJWos/BotSuOKf5mt2ggl34c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fht0C3j8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739257824; x=1770793824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F9iZ/hg5V9xXtSF6Ml/G7w4ioLmk3Il++H00jxFw/Z0=;
  b=Fht0C3j88OOGqmDCS6513yIexmlWUa83RIraki4Zu674+P5qMfVRNv43
   l2XgN2hJfoVvpvzunRaRZPDjR9hOqG8FPzb4tRIBynbuXXbYdSDMCXT7q
   ff1hzuZbZLKjt/iB9798SyJYgk2sD+zvLClbkQBUAxh5z76mpGy+8xoVS
   5h/03EXKH7+2toa3i8fa90fc3+vNq2PA5s26ZXLNXtm7Hyc4H+WvujLEI
   cYBK5i+90A6pbgw0Km8B93ho87KS3N7DIQIUxIattJgyrhVE6WLz07bOt
   tRH4bUuz8uS3bYFDlAViyyGaTecM8AsWwc+qDKjQB6+kzRd9j0EtfyESi
   A==;
X-CSE-ConnectionGUID: +BVO9H0aSJqqUyIZTD/OPg==
X-CSE-MsgGUID: FGOwO0t3RtqxF0SU235qyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39559304"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="39559304"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 23:10:24 -0800
X-CSE-ConnectionGUID: +obAw/VARxS+DTyd+CrIzQ==
X-CSE-MsgGUID: GPYjW6MWQxSK82zpT4EdRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="113061557"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 23:10:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 23:10:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 23:10:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 23:10:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AseqUd+X6L7XukPuKuMpPztZGPuJVJV/2SeTkEqyMomgaL5LpsljH/uLPDVTJ3ET/oWzYHdR8VMjl9ZM2BadAdG7Rro9gQq24fpVbSEr0Hh3OQXIrjBy6kmHxAV7T2eDEuZCheFyH3Y2LMZtGIwgGQH7PQQgqwO/HT4ITy0JV6+RByciA2JgMFgHrgSOH/JBzdO2Qiujzv8Cgnot0tzooe7eOJPXppt1hbOCo9EoFlU1aIMc0iDQ1dobmfPLWUPFRI6FNPAxAmGCrsc4lqXoY3lyl6511Sp2EVNK/Q8xMj3Ljayv58dTnOPeCHt4a1TZdZZkZG9vJiXRjqmsI3z8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq073i/AMe1xwrxj7709cla9vUih+rAtpG9mptBMAuc=;
 b=rZwdcBO+6WTZexL9WSDaA8kropoTf8pl3b3gcNJZeGbi0ZIZSx84iFiIsdxBLWvp6++bgISJ+8RnPUKqX6IJtoHQHEQLXV+YokDhZXCHuN15wEGnBWLaGjUpA5hoNH3GMwAnki7/3fNXTgqLTUvAxNtDYqjgswYFOlfD9Mj0+t7O2hbD29TvhMT1aRfT00cvvnWoe1uV0p/J+BHML+5YEDEAmxgNogyAXwGCBPyP+i/48q62WFfd/UxOcUDgCg9EfMyx6WyGs9flFlJSes3F7bUgufSbYndo+JMhALIMQsJjDT/dGo7SncDQiAmygBvnZEvXA8QjfVmOa7lzMqbmlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Tue, 11 Feb
 2025 07:10:03 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 07:10:03 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v2 2/3] x86/mce: Move message printing from mce_notify_irq
 to mce_early_notifier()
Thread-Topic: [PATCH v2 2/3] x86/mce: Move message printing from
 mce_notify_irq to mce_early_notifier()
Thread-Index: AQHbe9MauI8OAmfWK0iY8h18pWsqXLNBrsnw
Date: Tue, 11 Feb 2025 07:10:03 +0000
Message-ID: <CY8PR11MB7134DFC46AD440D42C5DB90489FD2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250210154707.114219-1-nik.borisov@suse.com>
 <20250210154707.114219-3-nik.borisov@suse.com>
In-Reply-To: <20250210154707.114219-3-nik.borisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH0PR11MB4872:EE_
x-ms-office365-filtering-correlation-id: af812930-fea2-42d8-c292-08dd4a6b1b4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?u9Mw2/eQF7KtIcHA132hP2kVGhSwzVWytoDUg8vw5Do2n2VxyxWKvrTw+Fyj?=
 =?us-ascii?Q?TsVoObpEb7LxoYTA7MFMESzrlaYoqCFDGadGL/VroV4nsUMHHYOR07i+U9sl?=
 =?us-ascii?Q?aEGA4H/CM+wXoqGQjIvK3udguGEkRA9veUl4XURKx1oyEdcQ8g8E9RYmLhbq?=
 =?us-ascii?Q?XZvfk+5jkrVBkeM1feiBNV+/s0ykpwsD5m0cXKE3e8jalFjvlcDGdVxrMTmd?=
 =?us-ascii?Q?pbT7bSeAWj4OIK8Oim3zUcwciDx+fMizjtNAaiNakIXhOE+Ru8+4WZW7mxlN?=
 =?us-ascii?Q?5WnJyp8yOm6DadDvsTF9SZYHlA/q+UKq5Krdg6tArg8CikhBlhQXBvwOSOEM?=
 =?us-ascii?Q?KbkhjX4GMJmjwfM4npWOZAG8/N27huluCAkeJ6Jcd/f5g/qarv13Op4p0Xkd?=
 =?us-ascii?Q?ppONv2tac1GjuU8htO2HiHJBSFhnFBh/s5mHCFPxDAqpEwrcptY0Waa2+AuH?=
 =?us-ascii?Q?XRZloQDRdTherO2oYH9rzCbBOLkuMK/GghgxnCoHzOhzfeFGg9t7t9XbMqAZ?=
 =?us-ascii?Q?/o8pEe4BGyYzXAc4gmggjnoFkkuG4qBgiq/rDczMa9lXNN/lUTwNiAN6guOh?=
 =?us-ascii?Q?iJSrgd3Ia7CrwkWJK/EYsuj66gCn9ZKXAZ37Fivhl3hs0kOuprNkI0gTGsU9?=
 =?us-ascii?Q?JFbkhnMHJZoV3OMYWgQ9igWXdAIU0iQHlvJI+W6W4glyEyyNlyDD6vKqnBKv?=
 =?us-ascii?Q?yREw8FJ+XeGCMDbpQcHZtwnRX6XMN/TT1iQ/sIYSHQzcCFCO8xiZGC22DP7v?=
 =?us-ascii?Q?7iUha9LLYi5T1R88E+oRQBOp1r9n8J9D/HqZct1AsEp353tt/eZ5O0D11YJC?=
 =?us-ascii?Q?eTcYbwI5DUsBpxbpnXjaw0nZcBAGjLR0Zr8JANMSDr2t8ypw0sA/gVuXpjEo?=
 =?us-ascii?Q?fpeBbHf1Fztcz3M5qno1z0lhFWrIuGfyiq+wQ2bSlgLjtDDiZxDnAWXvOxTo?=
 =?us-ascii?Q?tsBNX3fGghscc0GO4UBnfFbctTnToxzGK7pTDi0gCVL0W6kvjfL49JGyLgdw?=
 =?us-ascii?Q?AxxGi9ixxqAw/cid7aMo1Nbmto91+JnlImh2S6HaJbqzeFa1Dco15xggD0fc?=
 =?us-ascii?Q?iHOOg+ZT7s3OYfhVFnzBVvB8Twg6q/gKiOPF24Z9UiVz2D924Bo43OTVQ5+V?=
 =?us-ascii?Q?dXpGrTEv9DJ+BIomJihxwcM9dl72CJpXW2j6AlP6ifxzRQBeJ4E+KK7hpFQh?=
 =?us-ascii?Q?aHAnZNQvFiNA2mYfHafhNSY2/FWFKbqGL0qkkM45Ii6pZpC8GA3i+CWHJSo8?=
 =?us-ascii?Q?tYzNJBehVuEtHD9aepmuXO54OpGBbcfXVdsJ4mTSd93FRIr05HODkTt+so+i?=
 =?us-ascii?Q?uoERoqeMgysdlkcIEbDrI7RCTLNbpr6t5BiuvQA476srvyZlNkH66u8VaGRD?=
 =?us-ascii?Q?HvylwdIOhu/tLerW4sZ1RgGFBDhL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JWOaSO8cxReskEFF/SrZXf6xSvSWP36VMhgGZqyVLhdtPO9jkU8QB/ulT4Zs?=
 =?us-ascii?Q?bLpqApOewJ9UkaiW4jiKvK0y3zcBru5EAEIpnzy+0pcNs9pM/XV9Zb99dZMT?=
 =?us-ascii?Q?5bwRZVolfHtBhsvmpdkfxMT1+dAvxQyjxCL0G3Ilnp4kZ63/2enh9VZQCDUr?=
 =?us-ascii?Q?7u87z2qyXlDA/viQKPl22Kd7d0NAQCyEr5sxzDjSs2lcWYhZguONS2aaX7LR?=
 =?us-ascii?Q?xgRnBtn8NaPM3emyylfkqugOJ3s47VjJmnYU4cJ6h5IEAk1fhAcdrUkX7o1g?=
 =?us-ascii?Q?Ded1Lvm6xdbFW+mvhjMtQuY83MZRKgI1FQwkCUnHs7QQcZZKg5aEZJfzVtI6?=
 =?us-ascii?Q?lruZirokMFt0EETkwk+a+NEl6g282aJ0CclRSVnqz7Fg5MK7oilTzOS3Cy3m?=
 =?us-ascii?Q?MxpClN4V5sOli3m+PQv6eAjYj9B4mf0dVOx+cNsEg75klmOmM/o8f1hefzo3?=
 =?us-ascii?Q?aduVx7mhlz8Sn8Hq7ylaPDGpU24JcNi4RyqJ43ukjRFEjC3GcwvnXmSBY80j?=
 =?us-ascii?Q?ohTKfylXAIqY4Vw09r4ReEZ7l0Qy6tTLyxQnLTlS7qYKaLDLGH80/jvQCKmg?=
 =?us-ascii?Q?KgHa2OLbqagkocXY7UTfsFvZk8KUEruLVwHTiJvayS+8pQPD7ONVU4hahE61?=
 =?us-ascii?Q?Wu3/tL+l8/uZnPTCOJz8vF/WsOw9PZKnROzqBAWINSZsCsOy/bHF8OTnd4d6?=
 =?us-ascii?Q?ql2eFaIUcWRYeNMjC24MTOLpWdz/iwUkTkUyE06RMUAJjd0Y4rHAKxQw2B+7?=
 =?us-ascii?Q?fOSAInQ1breL685AOrbumI6vy4kOfsasuvjLREwP7mtsCRLA2KhLCNPNgLib?=
 =?us-ascii?Q?2/4nGHoxyMKmKSMwtwWW33PMcW+gGAhhKFu8dzLa/thuTK0O2j3e9tDQm22L?=
 =?us-ascii?Q?djlcGi8C0dfIpu0WT1mnvDO2wg7dywGFH4cRcn+6yywrHtoHh2c8KDkqmpq5?=
 =?us-ascii?Q?Xs1g0mkgWUrpq/xycKJ/7fVJG/0OBJ1M3pHzxQZLZvZXo2iUEf+WMCeqxj3U?=
 =?us-ascii?Q?p4ihN7NDW1O52XWEDPxcTehB0n97Dc+txVXnXwMs2Oyemrm9aLWia/p+DzIN?=
 =?us-ascii?Q?rwN/q0mO40lydoILNCY44uCTNut/RRMQeNG++yvHFnPm7xPTT+tFGACOT1gr?=
 =?us-ascii?Q?FIx1ndLw0mvTWno1IWk8Ra236yhABPaj+jipg8l+NJHCjKend6wm5x4uL+6I?=
 =?us-ascii?Q?qGz0I0bKYFy/6w4xiAqimO6nf9LXHDyLGQneWgie/TMS/wkl+ai0ZZPj4XyQ?=
 =?us-ascii?Q?iSWffc3hcNu0Z8BUhl6o4Zor9CKsZkI+CfzO+e2wV+vBRDLyJ/KiXppU7Yd4?=
 =?us-ascii?Q?xT2Tjptx5xQ/eyDpLIrw1kNavFWsHZxDhRvC9OanQVvc7p48WAqvFMUKViMq?=
 =?us-ascii?Q?2VufXIIxO2MCIqTtmXoxfeLt0b+clLnMR7qhvDx6rSwsYJRm9myNSYT1rbE8?=
 =?us-ascii?Q?N6NoQ8KxaibqreEQcO0Y6d/cGMVzxzUskoeZeU5rmlhUmZgD/88KNaw6zwzV?=
 =?us-ascii?Q?UTZTF9YNZ8jJBJ7ju25nzDw6j0hxxjyjg2qit+QRPBCGa1PnGDHp5TdKtR5b?=
 =?us-ascii?Q?SYT56qhEaDFbcJupMUR9U5j5BaeqbV3GSuBto26i?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: af812930-fea2-42d8-c292-08dd4a6b1b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 07:10:03.6023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gU4LgWBJW08y7C3I6sCFP5tzuQVzSH8dBBuMau8/TrwwHbZw3ANveZyl9W5ARRNpzvVOEF2Q/Jx2wL+TQ2MqGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4872
X-OriginatorOrg: intel.com

> From: Nikolay Borisov <nik.borisov@suse.com>
> [...]
> Subject: [PATCH v2 2/3] x86/mce: Move message printing from mce_notify_ir=
q
> to mce_early_notifier()
>=20
> Informing the user that an MCE has been logged from mce_notify_irq() is
> somewhat misleading because whether the MCE has been logged actually
> depends on whether CONFIG_X86_MCELOG_LEGACY is turned on or not.
>=20
> Furthermore it was reported that actually having a message triggered when
> an MCE is generated can be helpful in certain scenarios. Improve the situ=
ation
> by lifting the printing to the generic
> mce_early_notifier() as it's executed always and is independent of any
> compile-time option.
>=20
> Link:
> https://lore.kernel.org/all/CY8PR11MB7134D97F82DC001AE009637889E32@
> CY8PR11MB7134.namprd11.prod.outlook.com/
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>

LGTM. Thanks!

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

