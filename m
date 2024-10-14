Return-Path: <linux-edac+bounces-2065-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA3B99D693
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 20:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDD01F23180
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7136719E7ED;
	Mon, 14 Oct 2024 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BR2REfG6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AD231C95;
	Mon, 14 Oct 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930834; cv=fail; b=JgFsN4CZQtZ9QxEjXSZ0KNys7Xz4M1tnD/gwNYM7mJQmJ9VF7eMkP9GjHNxgI6t67qUtVvxOn5Kuu05pBiTvGlP7K+VfbE/feYe74OdMXUPVyD/yispfkv67KaeV/fJk+awANX366wJmpufP2ZSbiCBchHwQ0FJ9WG5Y68Cokjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930834; c=relaxed/simple;
	bh=Jw6o+BNJoEs3DNVG6YN3rjz5x6ARx/WdxepxwYjjdl4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TZ01N+eWW1+zD5LsXn+R5HYQRZOEk+EPpxEdZe/vZMlB3FSFztBLgoFBhIza24Zx7iw0ZQ/7XD3dob9Kw4y/vYVLRVnsyTy4Mf1QhhrhiLwaWq6/vpK3DLNtoKracd9FZLZBTzkJFtIWRfZMN/HgopqRC3Zo9MjgLguAy6T/G0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BR2REfG6; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728930833; x=1760466833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jw6o+BNJoEs3DNVG6YN3rjz5x6ARx/WdxepxwYjjdl4=;
  b=BR2REfG6J1ev8KeAExmAiM8zgT8SbszzFfzxiQmiswFIIv9fwj1s6wOj
   /wl1zZkQ970LglkpYdFnj8Jg/2fWcGEjBtv3+p70CeeQiPq0iy76aXFWW
   4317b6U+r7J0TUBEjuBEMWfrZFy8K7TU6zgASdcAd87uZIMQTDR49dCue
   d6cgBwvtpgzdZl+eegE3/Jt1+zhXwKrLpIYIBYcASer6zXDRLUfLheD4x
   +G6BjmdbAaMDsoMipBsTtq/OuETnrjeuPcOgjv9IewMX0O5vC1b1j9MUv
   Y5n/hnoG0nZwfZ7k37aei7SU0XBfoEq3B480Al7cEp+xH7ls5g8N8v7CJ
   A==;
X-CSE-ConnectionGUID: CqcTaZ+uTUOkypmKQR69kA==
X-CSE-MsgGUID: yle5aZd9Rw+eastN+Vchfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="50826478"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="50826478"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 11:33:52 -0700
X-CSE-ConnectionGUID: 9P6S1+T8Q+CpsLnDBhaeqg==
X-CSE-MsgGUID: xNdLsMhTQ0GC1B7H14b1fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="82214531"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 11:33:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 11:33:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 11:33:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 11:33:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtA65dFEvH7TGoeXzC0uRE15SR5p7xN6N/uv9kKAIifgOflVQIafVDgAAaU7Yhi0f91M1N9GIJsjjMQWsD2GP2d/PcA3qn83xdHA9yYFbV84yppQtcXuxKG+Li69Xzd/pNI+yIMfJHQvHsulQmvSZVmmTnTch3BG8A6xFIh6jcpc4aNGoYbnWKgGkqowXmqt8Nrb35oy204x3ZeGM+ZQE7HU/uF6BQigg7MNx+9IbQY4nKEFLaEoOJnT9wfMzKPAh/STNsIAFduAFlZGRA9ct7pwINcyB+mmGhJuOBjmjPGvORBv4qiySqziyID7cVV2H4LCnbjObr427M8dUR4+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw6o+BNJoEs3DNVG6YN3rjz5x6ARx/WdxepxwYjjdl4=;
 b=SXvJdFJmP+ghbU1Da2RFGloDhz7W1IWyaTL3DQByvPJiTIjMzM7Dno8EAvhFMZAuNvCgGgFbErzVhPkofI3scSzCug9UIcNfAmPp3mxG0MKW4dCBOX5L72U4w4fZ0QtOs49it9zSNW6isUAQl7OK1yA0VFK3vd0nYhvYhqJ+WpZyL885M27DzFnvNUJNnkkbbg+cmf28+jehT+aDVujc6J46qX0b0emzATqdW8sh6MyAK5wrw96Y7lrw0e74Uw/e84rdq9mUy0cNsxfEZGVgm6noRTJgjWkpV51N5/FtRaXIbX/fsr7tS43WC7VlTiGef7v2OXdUqtw2/vyM3T+BRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 18:33:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 18:33:49 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: "Li, Lili" <lili.li@intel.com>, Borislav Petkov <bp@alien8.de>, "James
 Morse" <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/igen6: Add Intel Panther Lake-H SoCs support
Thread-Topic: [PATCH 1/1] EDAC/igen6: Add Intel Panther Lake-H SoCs support
Thread-Index: AQHbHHmG2K6qdGwTGEKhfsmJHzAHD7KGlgDg
Date: Mon, 14 Oct 2024 18:33:49 +0000
Message-ID: <SJ1PR11MB6083B18DFC9A6CE3A4D0586DFC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241012071439.54165-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20241012071439.54165-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB4855:EE_
x-ms-office365-filtering-correlation-id: fa9177aa-3ca1-4813-e1f4-08dcec7ebf12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QuU0ewfc7FXS0ystYk7acUPQOWJRXA3f3UlPzA+8+Xp1JnO6NHWvlpoXJTZM?=
 =?us-ascii?Q?ywgcTTnbU4POBv4RnpN4v0GrDA4Xc26WcXpdT5JJuzjrvLMe/weKzob3hCg3?=
 =?us-ascii?Q?7wFYBPnftNJZ4aKjYfmQrR0kFhgvqIu/wMboJgS82A2P1izsj//kcPykI4R5?=
 =?us-ascii?Q?Ic0lyv8nvIOVFPD7HhnqIcEBXo5nP0ZcZ1rnXdVg7ETTQAqyTHDHptA3VmK8?=
 =?us-ascii?Q?xjDNcnZQVOc8QHpUWyEjhzewDpGOgRdRy9w2TE0St6l+IDcnw8U+QBtEQis6?=
 =?us-ascii?Q?2K3a+1w6rTFbIPRmg1Odo4uhS4ozYdlKI9Dq1MhywulmCQgfSsr26J5tbQ5+?=
 =?us-ascii?Q?iJlWg2fgT+DLR9/ZqYdONc86xR268YZRbtbOWlhBfUMPYq6Po53MZBD/NZCD?=
 =?us-ascii?Q?YiVwOK+67Ri6fUri9Pbq7GYozUhLMtlhlhXM1fUl8GCpT1mR/ayQL833YPnh?=
 =?us-ascii?Q?pmWIlZF4SRP1CSm2L3AC0JTckvhc43T17v9twFSsftRwOP5J5zjK0jA9g5Aq?=
 =?us-ascii?Q?RiZE+UPq5uouKGXCITn+vAXVjQhNjF2xL6F3gpbxBhhOQRUH6RLMI3tcssg2?=
 =?us-ascii?Q?5eCt/6sI0rhihbNkh5xW8quO0f75t5UdJ8NcxT6MP91PPXESkUqijW7kBL82?=
 =?us-ascii?Q?CajTaXYUWZWtK/aYf7a7PVQ/rNL3E7FLOU5vvJP/hHGxx+a3gQY155j5YPoK?=
 =?us-ascii?Q?3Jbx0pZxfYGxhZxJLp7g5NKu4I1oYdEOpWGZVgqxDMV896GJwGDfW6POQLFr?=
 =?us-ascii?Q?LdpVBkfQmhkua+R6xHdIkI4s6lzwKFcsarUYnI3nQlcQWF5fOjGj+iBVjuf1?=
 =?us-ascii?Q?moOupz8naGsRr/5wNO4yJPMN1RHTNS+xwrESAZhLzzgyxNhE6JwfzcreY0z5?=
 =?us-ascii?Q?WaxNLjoLjj8vhxGOc5o7ByVQB56+/jBLS8pdLti0Patkp8sSW7OpGHbYQZGu?=
 =?us-ascii?Q?eeerRJeTaXSgDuuJdtp+JCmCbog0iuQZFceBzl3974JecilbwKxZfctDT88L?=
 =?us-ascii?Q?Mf4+gFlT2Ms68bmQTuULRPGzat+tO/Vlsi75L7tIKqizQ5drv9ILIjFfy1Pv?=
 =?us-ascii?Q?R6Fv8xHG+mDX3bIaFQyN45OsiauWu2UNbNyNVep8WV9GRg2QfzM6ZonFRkJd?=
 =?us-ascii?Q?2uNtAFh0Fvk7bKrRkoxfLp+TaQh37U+AVSSXvH51+2RbrlH57PlbWHia7a3v?=
 =?us-ascii?Q?zeC8tJgekldPxhGMxLy0wQPbVsu+jE60pTvzqGKleP+9e0+audjkqQ1H5mBX?=
 =?us-ascii?Q?J0GhNchKZDEHTmPcxU4dBrUJzkFWcZOljQ0thF7Vgz8iaAyAmqK7fampT6HT?=
 =?us-ascii?Q?b8SympOJNN0VuK+Nn8wHAXXpj/9lg0kkVEpnxg4bR5ggJg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RABAYoUFl9Vl60px4OoeD+RvdaatS7L2kj3kJkHbcPCUZYh0ZliOA017Ay2Q?=
 =?us-ascii?Q?UWIYm3i6Ux6HZx1oFVZ0qwYI9ZIG9r99Bqwbc8+NyoOAcPdKKAzqYaMbCIhw?=
 =?us-ascii?Q?P4pa82WrRscJwvwadHDA6bzMgA6ekeYtVCU5Z3ZQAeo8FGl/EUm+8tLrd/v3?=
 =?us-ascii?Q?worry8R89lcj3nRHPaIAqiV3Npv+mm/oCdCn5fRSVU0/vgsofbpLdpm+R+jM?=
 =?us-ascii?Q?hUlv9Zz+csgXDg6jWMbtPim3JUo0kHnNod1xuzzMHmtXZFqh39zj+0PbJ3SW?=
 =?us-ascii?Q?rFHO1VwFi5ti+sLpinwIA2cEGFVKHsG29WvRbAgZRP5FhHu7iHOptvxm5GFA?=
 =?us-ascii?Q?Hs8ZUWK3ZSFHj1Pc2AfrTN+ZmdiPa6j48KkHPIzD0+ycJ/rb0ILcxFdaf+xj?=
 =?us-ascii?Q?KMtfdjAJIqQILLM8giZDtbyfwlRVGKg/dzSAxCkAQkRL0j+ZzOLV7HWyock2?=
 =?us-ascii?Q?7q4GL49mWR+wv4PTZrt7svKf1gCeVsXCcyAOr2LzPyWa1aDDkE3RdTkgDBjC?=
 =?us-ascii?Q?LhaFf0gR7P6OqqWlKLl2YfybsDuxpw/QggMI5DTXXiJoxvYujGzM1t5592lt?=
 =?us-ascii?Q?lyj2eojeRnxAwZZAmbtbgQ2yqGqF3ag4rRPZN9ZqPSs2qWE6twBKjvvojqrq?=
 =?us-ascii?Q?SvVM5+Z/+zqzF/Sr4pBYscn/IqTXK270QC1dPOY93LUMzadMLYXbUto7E6/J?=
 =?us-ascii?Q?VmTTrgrRs+JFgz7vO5M3hniqTWhRIduOHQCT9VIIIo3IiNJVQDFboxvM0rYl?=
 =?us-ascii?Q?Q4bfv5V/ubT5sTBQpH7Q4YmCi66D3TueUBPOZ97PSWvk1UOWbTzDyQ2cBAxJ?=
 =?us-ascii?Q?dPWBpJmH9jLQ5WQCOEjfFePCK5L/+yUVjOz0iyOe0gDqwfPCnp5z7h+ZkocI?=
 =?us-ascii?Q?dQdyqrke56EWadd3AFlsbiMFzdNANRh05QfSns4QlJVIwRZfsyPdsqwKAww/?=
 =?us-ascii?Q?0tPE09Pext6qMdGvrm8H/yvc9ozrVsKwrUNAdB3atU7nupSjevIOpslzvA4/?=
 =?us-ascii?Q?zbC8U2/3y0JE+TN8ZUZyfjc5OzU94yHbWbB8WRlw50hh1K4pqPRUHcsjeQ1b?=
 =?us-ascii?Q?3m44YFEIAbDaZaUurd4t3X51nHlShXmt+A6d+eM/RQZgrp0Xr22/VH2TqCyK?=
 =?us-ascii?Q?KYyStHVD+FK3FBZpw4b9Tes+sDKyCefLNvmm0qYgtctE2ovSezC/Et5snFXy?=
 =?us-ascii?Q?E9m7YIwWXxj2l6wQFh+e7r4vcWcIGoDXtwp2tQbLcxXZGiu+RIvkdagMGFiV?=
 =?us-ascii?Q?zU2qHVBA2hL/4GQbEc3hL/syxEOOcXlJ00LYB0Xn8UVL7gY+Inv6ctGXGneW?=
 =?us-ascii?Q?HeONegbW3/iRhdSzuI7+YMjr4PX9oTQax0WXgbDNLfU30LDRoY+AVhnh7Q3X?=
 =?us-ascii?Q?yDtjYZaf1Eg+JoZD3/xLJRF+wnt0sx9dytAhoElrG/RNRoE7hnJgBYK0lByk?=
 =?us-ascii?Q?EFldrKlttzQplvQDC07XLYdqdaf27JPvN7nF56qVa13CvtXD5WDSN6AXLED9?=
 =?us-ascii?Q?4URKbv+d2L9dcjCXzrIOECNW0AU/aQFR5m50G4bAvnj7FxHMhHzRmhMiNpYx?=
 =?us-ascii?Q?kgOomG08+yoRlo3Tkh2copEw0XXDTSQ2qHn5Mm2V?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9177aa-3ca1-4813-e1f4-08dcec7ebf12
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 18:33:49.5244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qme9+BLxD+2QhiosSZUOqe7fwWNx4CzNqRhTTeRA0frHNnx+au/BReHRqgbEMXavlq7WG4JU/8SAkACZbN3myA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
X-OriginatorOrg: intel.com

> Panther Lake-H SoCs share same IBECC registers with Meteor Lake-P
> SoCs. Add Panther Lake-H SoC compute die IDs for EDAC support.
>
> Signed-off-by: Lili Li <lili.li@intel.com>

Applied to edac-misc branch of RAS tree.

Thanks

-Tony

