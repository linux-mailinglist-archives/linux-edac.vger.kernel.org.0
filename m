Return-Path: <linux-edac+bounces-1293-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9812908E73
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2024 17:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0901C24FB4
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2024 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC16916DEB3;
	Fri, 14 Jun 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvsa8j2k"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BBC16B72B;
	Fri, 14 Jun 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378034; cv=fail; b=e/dV1IS1MoNfNKuL/7igJgGJv67HLc6DVIsVorlYB7jM3UwuPEdREKrK6awWylTWlL6BVd/ZE6REGCx7OWpBfxK+ljj3bzGeSs/WJV2giiibpoFVxxEaql7DdaQAAYgbp9iJS/jtXLEsQpJL/FmUGqZfSaC1JQFhQOeTfzHlnFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378034; c=relaxed/simple;
	bh=wptOTkphudZb8uslcf+fctqrSvUCDcFJ/udeF1Ae22Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L+DcYExQgKkPSxqF7YPg22IL2dVyPs+NvlNfbS2D8TMAnYZ24V3fgbd2DOO3VyrHXzyx47TJzEDG0Vzbna9eNyN/qH4eelhOzZdJtCenpy5lLqUrzU5OqYFjxqe4aNXCLB2aiV49ZT/++UfeoxI9Nxf01LT+dirBI5o4FmbDkUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvsa8j2k; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718378034; x=1749914034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wptOTkphudZb8uslcf+fctqrSvUCDcFJ/udeF1Ae22Q=;
  b=gvsa8j2k2lJHGZ7PwNoit/927xbKhiSdyO42mlQ40D+WZXdXx2/XD+yr
   k/8DHKrNuSsDLYMdhThBfpZ/4zuOhLJwYN+aEmPu1wiZ5Yy/FKqYjaZPF
   wq5QAJR+vPko6913CitlCWoBU1Tw+0jgwjrSMeEZMDFOu6loDMpwLtiZN
   ISSp5w8EgG/3grZLajohbMRVfdrEmb/Q+HfYY8BE3wVZbaQUl2WaI7d+G
   wc/2vhwbBUcJKcq79DoP54fQmDemmInrnE2vomE+BwvSQ/WLcB2IB9kx5
   d/tIpK+Zs+HVeWcHiI3KrdjuMN9D4wEuG0IDbiF/87SkhfKQtxVEywJM1
   w==;
X-CSE-ConnectionGUID: VZoNC8cFToCSCD4rB4zhwg==
X-CSE-MsgGUID: dRSmITFQTi+cMSOby3bvKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="25843612"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="25843612"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 08:13:53 -0700
X-CSE-ConnectionGUID: EsqpvIguQP28pw6Jxu/gqA==
X-CSE-MsgGUID: 2zRmXNGnQf6qsTgTP3T1LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="40403485"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 08:13:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 08:13:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 08:13:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 08:13:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 08:13:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBqf9/tgTOdUl9CeTxTAg/2U9vcXBGLZ6eNePTkvgl+JHsqQ7Bs8n0rfkFyNTnG3ofRo7IYpjzEwtNMEnx7hYX+BU5TPZctyN8VsAoNTNLY/j2CT/xLiQc1rAOS125S0DD6mbqCektZMJoAGxHZ2B81LSymTISfE+uH7PTC5swIbzmwWYPh2HGVe/Z9htWu4/MKhA7LxWeqC5CtoB/p2xlHJmEbkhWj2b2IfNgsgCTIXjUwyXDQThkt7iPznUU0hJUkE8UIMG5qWAtElYkN7LzqOfaw85wT7Z2Itm6VAjtzENF9H9rJZHpqv3bCzIKv8832hy3AnZVTqlUBYA30AVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wptOTkphudZb8uslcf+fctqrSvUCDcFJ/udeF1Ae22Q=;
 b=fWT0BkuH6+E/3KGz0XTDmMe0mIPx8c6/vMV1SH7SAFISNOteTQLsJB2jkoBeRCI4lWWknzr/oNEW+qMMZRU44QwJUOeuOc49jpC0yIS7pWOdbLYLPJIKGPnyA9wG2sGq7mv1hWMiNJq4azPTUqrkchG4AaaBB6j0/tkDNSWoZ4RyJ13jXhmufxz6WjF8W/0+IFpXA2lSBYaJS+l2LDHvcsW9owt/QCY0ZXidM6qWw+FQSTBh6sdHSW0YQjS8wKBaxfTXXln8aNTOkHhpWzzgDX2y9MHzLJqflpD+mRY/k0CFm3aOoVkhfdSgtnfeDvdfBAo5zxhhmNKvL7obmCuk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5028.namprd11.prod.outlook.com (2603:10b6:303:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 15:13:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 15:13:49 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@redhat.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/igen6: Add Intel Arrow Lake-U/H SoCs support
Thread-Topic: [PATCH 1/1] EDAC/igen6: Add Intel Arrow Lake-U/H SoCs support
Thread-Index: AQHavggj5LNeKDDKdUG3DvmjsZqj+LHHXp2w
Date: Fri, 14 Jun 2024 15:13:49 +0000
Message-ID: <SJ1PR11MB60831A5611FD481481018373FCC22@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240614030354.69180-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20240614030354.69180-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5028:EE_
x-ms-office365-filtering-correlation-id: 863bdf48-cb6c-48c0-c492-08dc8c849802
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?Z3Y1w3KPxou/Eiaguc6QPTDoE9OB7J1d2nR4IobWdB3f+6dri/X+IkyLQZxj?=
 =?us-ascii?Q?Jy5vNa6wDcAd+4v4sva/PNteI5RtnK4YrFGMoIF9HyCQAWkq9SKtwhnP44DT?=
 =?us-ascii?Q?qC4O9ZePEmWFll6Z4iGsm5PkSV4SECD1P0sISlWQt++WLhqMj+KOi5w4c2dn?=
 =?us-ascii?Q?dCSQkkesXgLgOpd6M9XqHko3kfVYAgobqexCaSTUehmbh6sUb7pBX6Hy4P6J?=
 =?us-ascii?Q?HH7SO8zYwrWofThgoMg+WQKZA4GXCEJhPtBBwTpWl1KUCjNyu1mdKJ31LAl8?=
 =?us-ascii?Q?PRypNniSHEzGofByHxQO2YRbqG+G0co6sCXyOGgryG/97lyIK24avs6q0RrC?=
 =?us-ascii?Q?bHXKfBMT44dASzqA9eXm/pPDGa6K43IaYuy97QJWkLPiWKQ3A9Mo8wywXLo5?=
 =?us-ascii?Q?DJijTc3P2uGev+BcQmGkb+soDEq3yGqom2cMlGI9q1EANnG7yVmsQ82xTQG2?=
 =?us-ascii?Q?OmKfmc2bIP1YkVJWvoI9Biz4BYAPWNT0KkFOWQRlTS1esLcuTnfd7il9o31C?=
 =?us-ascii?Q?41khPavphXsSRDbElfAX9L3CFjwEi7UnzsoaIESo4TbzBqi0DEeJsePtlsLd?=
 =?us-ascii?Q?/bLSf4nrfaQvGYo3BkT10u/K1/jIr+FaPa0hATVb9MPfQiCjjiaYsK8zAjD1?=
 =?us-ascii?Q?IH0/KOK6kRkR6Sjq4caB223TIZMFl7GO3bYqlltWBKm7XVvFKibu1RpPXguf?=
 =?us-ascii?Q?vIML6Mke8u/4S2DX9Se+h9c7aY1vrr8TR1eSqgePFKjlyX6l05vesAUp+FwY?=
 =?us-ascii?Q?F73Kxi0cbQRJ72YagiOs60gERPTEB28cLMAupWeGn22jsvMvdgn0e0yBX1lW?=
 =?us-ascii?Q?D6X3OC3jvC+9xVcYy/eU07PDj+KWs+hRpigBaVa5f2xV0zIQtf2BmFeqUWKZ?=
 =?us-ascii?Q?uCxO/a0gT/mkRWf/uzHYou38fKU2PufE5EnK3Qp7yIzN04/vt8zbE4gkgQJ1?=
 =?us-ascii?Q?xYjF7X3S7b39nnCTZrQGI8IgDXZPW64UbIDqsDNs5FF2xsU34B5uUTki4FQh?=
 =?us-ascii?Q?rWqFg9vLgVvpBeGsoF09/rC5s6ahphTzpqVqQpB5jNVHMmhKURCvZYiYt8gw?=
 =?us-ascii?Q?VUiVLQ5zkV5ZT5LjYddCyqbYmlZYZt6ka3NsGsIPB/O0jTnyTlfZDf07YEjO?=
 =?us-ascii?Q?RrJ9VqS8rYULwD9AuJfRApRvxZ8pPNNJ/sMXQx5XpFswdbAUQvvVAv31GgGA?=
 =?us-ascii?Q?zwOyh9Smo75w2QhOzvuufP6Q2oE1ZFMwViz0enC5Bnf+4jDXMtFyqpHzGL5e?=
 =?us-ascii?Q?2sKyaMchowmWHiCH9QrWi1Wa5XoNjPNhn1O9JCoqLgvhA3r126SkZULZYbNe?=
 =?us-ascii?Q?G0X95B8+k6wahbDNjbGZaP2WMQBzzO1Xi2mhQnzPhczTXinYiR3OiBxq2rYM?=
 =?us-ascii?Q?o+yl3f4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uzdDo84hIlQ1MsKOfDKVyksv4VLxm5KO6t+OilsJZxuV1MqSfLg9gUV0gYgs?=
 =?us-ascii?Q?XTU7uai1pa8FMhO7ujhoW//bq/7yom8rVVv3P9+ijGpuRydFMzta/kjPQ+J2?=
 =?us-ascii?Q?Vhq5NqEeqql2R8XxKK9H7ytFMoF+PKn64IIYC12PP+Iyl7aMceltHKc18BA4?=
 =?us-ascii?Q?I8rsLpT7GNMpstv27YInnJirL3Q7w685FgpsLtcP6FLMNziq07C0vF4kwCFH?=
 =?us-ascii?Q?4zp8wKpoTJyubGNhP3Oj2hfYymTAyoGHDGqaJURe8UIJ9DBIpab/MCGHRgxp?=
 =?us-ascii?Q?mH3CK8eh0GqKpCYtn7vdrM6o1WHtAvTgkQzaiBvOJPTNFuw04DgdjNUFtVdo?=
 =?us-ascii?Q?a4OHCDblOevIohh5RRU3gDzTwoSGTvxCEFeKbQZD5d+9SUvjMRkjcmefFt/8?=
 =?us-ascii?Q?2qb9Om2+NIQkhuFu3OhtqALt8ukEEmWZNq2/SDMTDo+YeRDpp9xKOgeVmHl6?=
 =?us-ascii?Q?D53RTVPm1QmxeOvCHw73PVftQpzQMHDTfLQxKonLxPj/T8HJxgeSMyH3my2v?=
 =?us-ascii?Q?ZeXSDjXS9vXdQQuA9wY+dT++bThq0+jc4Xn+hQ4geAXk5g6vHGbAYiblP+nP?=
 =?us-ascii?Q?eVFuIK8Uv/NkX7EfNLoZKi30EPLOhD2O0DZz9CASH3TFHPG7bDrs3G6TkL7L?=
 =?us-ascii?Q?lVkpC38C+rMh6PZjxatpSR3YZNsLT88V2z7D2c1nTbZj25g+frTRZATAd/WY?=
 =?us-ascii?Q?eDlP5SPqlbwl91WceEDGrIz7SS5uy68TqEkzybI4/HIvnnIuuMbUxF9qiAnZ?=
 =?us-ascii?Q?FUshhjOGlmd/OM08ApDqpZyPcpjG3pXyr/LFoElqX7o5x1/ORG4MbCn1TT8/?=
 =?us-ascii?Q?kdAXh3x9J2cQ5hlXBKBssyviZNr/7ZINDjwRgJSEbV5pVFSJvItUUyIyYio9?=
 =?us-ascii?Q?d9kvbgC5rNMNdnaI44uT1wnwInXRiODZnc4hxDlFAASjlJThTjlH1A81FRbK?=
 =?us-ascii?Q?TSkm2TcJGFOQJMRfx2edM8crAxX/GI4RxgzxZaGYd3XzRqrbgHFPRPdgAOS2?=
 =?us-ascii?Q?ZTW+zC319fT5GIQllRd+NjlYT7vpC0q7nm+I/4lMDz0b82Ygii5+M4f3Yx77?=
 =?us-ascii?Q?VdU11AdZEFuPVTmS75MJ8qs0ZS88JT3UHk+QlurWt7EzZ25x8eyUnroPI+yP?=
 =?us-ascii?Q?WJyTT4vWmYnt8uf9q5GjNPfZqSXO36doBKdfxIUt2ALpbJAF1l+dBLn4EgxT?=
 =?us-ascii?Q?KsNWTiISwlQ8Csu81sZT4MU4kbquHkQv1kJwtScMwh5/lJp5jzcD5RIaPa8F?=
 =?us-ascii?Q?W0/g3ppdwwoxQMSNbBqs+q/3DmoVgXrhPfAll+CRMrkklUksHez/Nn2Srgqx?=
 =?us-ascii?Q?vBGoC1cDGkC7ArM/UKXur3YbpQDZYrHlnjZ+U7k/YwRYRCWAAOHHfBNMTVfx?=
 =?us-ascii?Q?YBRrTaSlfIFrxAjtHjc5EXO8hwpn/l8XMbdKefQ0ODXgJvnfroR2ewXeh2PG?=
 =?us-ascii?Q?i32h0bszF8c2COG9EmnaTdjDQtCDHgUz9y6gmi7IeagX735PuOBwKJiUgEXR?=
 =?us-ascii?Q?BShphsNoYo+y55H/CRQU92MhqkGjOZedYtDn2D/1v6G2BUDJzdRpD8tUVsrr?=
 =?us-ascii?Q?ShOW5ImYU2HQ26knKzVrsIvfR8brfyHkQ1t6YYtY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 863bdf48-cb6c-48c0-c492-08dc8c849802
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 15:13:49.3202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMabxD7xDnIFZKvqvp3RNn5dwIcRsVmP/a0vIf+kI5i8bGree/sqAENrDp0jsNCSkvft3dODXXKuM7uUT6F1Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5028
X-OriginatorOrg: intel.com

> Arrow Lake-U/H SoCs share same IBECC registers with Meteor Lake-P
> SoCs. Add Arrow Lake-U/H SoC compute die IDs for EDAC support.

Thanks. Merged to RAS tree for inclusion in v6.11

-Tony

