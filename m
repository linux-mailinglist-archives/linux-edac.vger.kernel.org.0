Return-Path: <linux-edac+bounces-2227-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496FA9ADB7E
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 07:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5000F1C20A65
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 05:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92D117278D;
	Thu, 24 Oct 2024 05:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkyidqc9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E442048;
	Thu, 24 Oct 2024 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747555; cv=fail; b=P/wQYH8KWEVTYGH35aGNWr9dTlf9vxFw6CHCPMMQ08eG05sJqeI54XFeea5Y5+WMYXUzvDom/9wB9bGSq10MqXr7HlwS82wyJZakCI73qvi94Sdeh/9MHeN/LYwxspWCZ6RAeIT00ion+4qquwHdmXeHN6S4AYuBrCW12kFz4og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747555; c=relaxed/simple;
	bh=JJJYXAQaH6pSLwRtjqNMb3qVzJ1YAqJJBBdnDgp5kn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b2+sh9/yJkgGIg4XFYCX0roCRrdjbXUeakio/e0GHD+T5mTPwL47NKZxxJXhx1FyO68RSa2kQhDJlTM+U9b8LXvMoovmKXtjU45VC9lNoMY3pIq9EalFul5Caa8cRgTAWTNi9emhxzOTPEUI5XIWmiyAaPbZiGoIlDoF+Dt5Z0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkyidqc9; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729747553; x=1761283553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JJJYXAQaH6pSLwRtjqNMb3qVzJ1YAqJJBBdnDgp5kn8=;
  b=kkyidqc9ShVNsBVlH1abNC+EjpigibuSfFQQjhm7LEGYU0fZWmyKs/T6
   GS2Dw0TWGHI28ptB4xJYolcX1rwHELEFoNze+vcAyCUskH98JJKRh6KH2
   pSfPS7+7a7M0qhL8T8z4q3WWe4MEgOaEjoWpgJrhBaP7Te/xGI9CV/vgA
   aJ+hOyob3lH2C6L2wgVXJr0EqfokQpm6uMpOa6P6VslmlEC8W6XpcKzD1
   X7djV4d46aO+fLxx6rA9hIuUQdXphFvGsYFkmevVTB33NMy/UHCZMQgw2
   +3Sf3gMy1YAWwYskGh1P03LdmBdggunjD18S16mpJjl4nI8eVlLAD28en
   g==;
X-CSE-ConnectionGUID: fk1Po5vHRTChrbVbvH0dJw==
X-CSE-MsgGUID: bQNbdv9NSWqLNSbKkYvD8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29472019"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="29472019"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 22:25:52 -0700
X-CSE-ConnectionGUID: INI4JeFxRDq7xdTGDy4bYw==
X-CSE-MsgGUID: fSwE4WUIQUiA71vfLwtzbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="85274410"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 22:25:53 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 22:25:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 22:25:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 22:25:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tojj7X2pjh11ShDTLQbXcVO8ZbMTO38aSs4kfBgwgU58PQHMr9pKCzMl3KyCzwLBuQjg7Sf3+490fmHYr6dcqHef6ryVBV1m66MRzUX0k+A4rKzoO7prg+HVsU+256hty/jYy7gp3Jl8eN+t3f80hG4jbhKeTn70p7WWDpvBi4XpJ2ANlWJTxyKwAYsU8+Olhjt8TVM/nKhHJ8JfFEUkJ111DSP1c3BNHFY/nuooDzXxiMbDohpIZGk1tNkp+mi4mvVydm97KwyS2BMJlO0R0bVcWlgjf+mHfYUAr0UDwL7kNjDNfKWNF3+sV1qWN1dye/7JQwS7CLPUxKXQtaRrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rj7ufKOcb24CEzR02zmYc3EFqp/yvA6FWxTDmtnoN0=;
 b=P/wBINmtpnI0x8EoU+JjIfShekia8l0nlem6yNMlNn46zIx+HmPgBJ/RXxZag9S8KBrCRM/vKtExbGBNTrza7tET1QhGZZOG4rlZWIAd9SVSLd15iUub+7NPXEl/FoOExWG3ygB8nKG0uqBEvAwDpaBkoJ5d9XPVooj+tNOs3nUlw36h3wOCpQS9CmXY8FllEn6pPsFDuBxlgqNsFLVaJdQNmdzbCVdWAOFZByQJTQM5gwn9rY+84esrk9JiCeAEH+ogFpv0DrhdYD+xQUQX2WKBgEEVPmsKzGHDW8uhFpZyV/37fL6M+g5USE9LF6N2DGJ/GLfDGplDVZBt37zmaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB6380.namprd11.prod.outlook.com (2603:10b6:510:1f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 05:25:48 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 05:25:48 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "john.allen@amd.com" <john.allen@amd.com>
Subject: RE: [PATCH v7 4/5] x86/mce/apei: Handle variable register array size
Thread-Topic: [PATCH v7 4/5] x86/mce/apei: Handle variable register array size
Thread-Index: AQHbJLqto1Oy2B2dlUy+aIUSEQfqI7KVYMDw
Date: Thu, 24 Oct 2024 05:25:48 +0000
Message-ID: <CY8PR11MB713447591D1C8BC77F39118C894E2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-5-avadhut.naik@amd.com>
In-Reply-To: <20241022194158.110073-5-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB6380:EE_
x-ms-office365-filtering-correlation-id: 70202b36-881e-4788-08c0-08dcf3ec514a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?l0BgyPvYOP64Dy+oET00pYwiN/dAU6zdaNSQnmyLh4/wcgo1+zWFRp92pR4x?=
 =?us-ascii?Q?1p+tYJZhTygfJrvdFuYmmSrWz22njdWSDvc8+XxlyUppzgFzrHi10gHlnMn5?=
 =?us-ascii?Q?c9QP2ausEU+coNGfkIx+/mExO/D/ffB8rto8Nf+asoIEz7mlvhzmnjkfH/4e?=
 =?us-ascii?Q?ryDqapP5zl8SoZopH3WqdYMtJkhAatN//rP/rBiXbmBkwKOAO2ACxgT5OFYR?=
 =?us-ascii?Q?g8eA0EjjE+KuC4sxv9QX0IwxRczSw6cyIxsTZs9lpY7ujj7NMTc7qdWFhNkT?=
 =?us-ascii?Q?gnj2AJ4VZvD2c+9nmleHrHHaBXmcQIINr8SQ3ywNtOBHwlUMiPorrhkGZuqi?=
 =?us-ascii?Q?5IvP8ahGpuVwlqpbAGEmxcqNmP/1KIMI2h1TEydpfHnsPzi9hb1ssXwR6mf5?=
 =?us-ascii?Q?C4XAp0a9R7PI7JtMl4HBJKqO5PHX9yf3Yg0CaipJtI4Y7cxhN4NuPq0Pz4lm?=
 =?us-ascii?Q?hziwCdGAEu7whOt9YwVNiVkqFoSPm7U8y/Y+9zoUeRBTj5YJ5F1JvkIV5MRf?=
 =?us-ascii?Q?1jU7HddXZ0h1Tv9QA0j42/QVyAZGmA/YEHFK1fKYi9jmMk3BqPXm5m51P5nJ?=
 =?us-ascii?Q?j9aips999IszrJSNRXEOActoNi1DE5FwsRl24sG3UjIhNZclg1OY01NoKgk+?=
 =?us-ascii?Q?ESbt3lFV4GHToWx7Cyf1pcY4CKAisoz0BijOg2MR5MqyGXKkLfXykhqk8fZh?=
 =?us-ascii?Q?RXUkR0qaBki74MfJyeLI6iwonAWOLLK7O6qJR7V+oYDo7CsJJ5nE6+ZfZNuK?=
 =?us-ascii?Q?W8JBk6yWkSeAH/JA3TXBAQHOJEu++r2Au8afCqpgNVNs7eaw0mHZCL4Dz/FJ?=
 =?us-ascii?Q?wOUnWU1MjxPcuuuTeZwaV/hReOaHV4xTG2VwZYEDd6F+OLSNHdT91A/RN0pS?=
 =?us-ascii?Q?6hLlFt9GjFAtWcuAZ4hfbLSl0iS4QO3Rego0hIm5np7oaL6OE5rhYLEdt+3v?=
 =?us-ascii?Q?cgc8Dym+JHhaDMgSVHwuQRBBmmTALowSG6DDr8i0N40uPIMPFFnrjoRn/Bij?=
 =?us-ascii?Q?SmXH4QZXF30ou8blNzIBRyP2uAO8qdqDQ3eFbJ0LwM1CwRpJQGzxTfcvnbkj?=
 =?us-ascii?Q?uAggcIKXc9AObcNIHLFQFrn/p0i/T23kaQgN0i6CeKp97o6xF2Q2zKHfjpk0?=
 =?us-ascii?Q?ASgSmDvGaDgF7X/7RrnJUHFOrxHN1NAooJMsmkzDNH408TcKIwTK5lw9wrjU?=
 =?us-ascii?Q?ApxWu5S/Qv//j81bGCjih21vMMn2FSBXuKgnNCVEWelIsex6Vwxm9Qikm6fU?=
 =?us-ascii?Q?C6xt+HYopbajxNqCiHh0A3tZTFVsUTDjn8rp5QUvHBv/32B/RztmmwiSU7NY?=
 =?us-ascii?Q?zhYyXm9N0KOBieCVAzJ8T4UEePDmuAg+l2UDd4SVPd/m0CdZAXGXNL6C3Gzl?=
 =?us-ascii?Q?9sG+vk0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3hotlFMUGd3gLlxW+nlzduxTZfm/Cxp+JYG5HfkacXH8PJtqywOf9fazJa5r?=
 =?us-ascii?Q?68WQ96XSZ/Y8sqU6J/tnE6MCK6x3oScnp3k3II89wI0Yt6RE8hTzY56ZIMZb?=
 =?us-ascii?Q?q0WPqgHdQfHIjDBMdRN4H7Gs8xPp2+lRw20rojgV0BcSAWW5khSfGXwa9IHf?=
 =?us-ascii?Q?0Z9KR20x5AwTLfL5LAH/E+GQagrz5TUzPzybdsv/O/bumYa/2lqDhroMDn8W?=
 =?us-ascii?Q?3I9knED4LxJJEGHcBzrzw9eDR6s8vM8k7h98hoJ/CKXF9ojUQmRrzbhaUIx7?=
 =?us-ascii?Q?EZF5pS/z4MJMI2ZTy6RlCSyrlINWJ7jW/8TOB6VBUngSGmR+s6UoFAKtqtGn?=
 =?us-ascii?Q?gEG/jSLKdxQRNL8oB7C5XxYHkTyG8vCSwJyl2heMZQo5aLF6XkAGQVBcHS5y?=
 =?us-ascii?Q?vvqzFrxqaegkCr7YNi4IlaxzvkvadGsDPaykoZaJtArc1w3BQAFbH99VVIe4?=
 =?us-ascii?Q?3h925w+bBhYT80JFX5cAqPGIRS90pNWpcZuf/qiGIDvPO43GpmT3vjJbiwcC?=
 =?us-ascii?Q?j/QPt2zdni803hjHrjaBsDgD2mlXEcP1WYkIwubgS/Um1M8gzJjCpa7TTYOL?=
 =?us-ascii?Q?KIL3NphZVjyzNt9i41n2eI9Sp/F3GLdiGppXCn+Aoowir17bMLCgdbQV6SIb?=
 =?us-ascii?Q?iCDLA+7AjPsSWArFSV4WhXDFlNwex7unkkMA5goppy+9BWgy0HneGGTlqFza?=
 =?us-ascii?Q?EQPL3wM3C/F4YJ3KrsvMHWPlcSmyh4JBZ7UpsEhE566MwGOdG5UEe6Vy0dyk?=
 =?us-ascii?Q?AsXt3rziNypf0ywufPcBXvPp+c6JapVzRe0fjE9khtuipAP4nVdlc8JC+d72?=
 =?us-ascii?Q?usnqL4fhl9EDFyTLffwQRsnt/hco69OweIbtsWL+HiAhV7AtRat5YyTnz/4f?=
 =?us-ascii?Q?pBakz8Yz0CL4mv9b/a8mZu8rtAvmsM8XWkivPxUh3cU6Ae58OLDPdH2cNylm?=
 =?us-ascii?Q?2mj6ao17XGme4/bNwecgQ3UPBHO2hg30ZwblhHI7CzlvFwgQaaKCDynPUVG8?=
 =?us-ascii?Q?rDk9QNg1sdmnpG8K7n+M0Q3wv6BY2L/uW7bIY2ATHK2KtNqQ6M3C5kviWBUF?=
 =?us-ascii?Q?tHBbE7+2N6Lzb/kin4JOfdQikUlCzr9uFAZP6zqzE3nG2bToPUUJ97EUHN3U?=
 =?us-ascii?Q?b2LrjulM0UURJaSjOZjUaMrVUoA0Hs/Si+AS8OjLmEDFeK/HYKiFn9lB4d01?=
 =?us-ascii?Q?BvGU8WgRJjVAwMuqAjQuIsfz7ayx5z1QZ1dAnPMVwX9LZQ7v7AylC5KlVQPT?=
 =?us-ascii?Q?0sMjK7WVVMg8uTY+z7tdH/vBG6/yhrorEXIadFQ1+ByZcwEIt3qzsoRBtpdN?=
 =?us-ascii?Q?cpKiV6DrA3EQCGpZOL22kAUpZPtozbX+0ERhLcOyNCOrxtRBJ8jrrlG2GTKD?=
 =?us-ascii?Q?YaXNuWaUdbCB+L2OlN0yx7B67jyAQArSGqnjGiKBNXtqStCW6mi5lVGaWXV1?=
 =?us-ascii?Q?yjNsAYClyNym0JvBvngq32uldJSgmqYc5itl6GgVFWzKxIFyeSg6UD8iIUp4?=
 =?us-ascii?Q?tsR/xijOtOBpsJU/EDYwPWKQR1NmLkqn/9Ybc4exNpgQg1yIGhSZ828jHub1?=
 =?us-ascii?Q?fl4eUadUDYHuGEIhZ8YVnhB6Fs4A91NLKBWhs0Pi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70202b36-881e-4788-08c0-08dcf3ec514a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 05:25:48.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r58Ex2ceRZiDK3n9maLyYQ8kAo9dScBN2P0hEoCLdw5Z2VPMmb03+LGx1JM24fYb7UvUpjD5epqmaePcLBKXeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6380
X-OriginatorOrg: intel.com

> From: Avadhut Naik <avadhut.naik@amd.com>
> Sent: Wednesday, October 23, 2024 3:37 AM
> To: x86@kernel.org; linux-edac@vger.kernel.org; linux-trace-
> kernel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; bp@alien8.de; Luck, Tony
> <tony.luck@intel.com>; Zhuo, Qiuxu <qiuxu.zhuo@intel.com>;
> tglx@linutronix.de; mingo@redhat.com; rostedt@goodmis.org;
> mchehab@kernel.org; yazen.ghannam@amd.com; john.allen@amd.com;
> avadhut.naik@amd.com
> Subject: [PATCH v7 4/5] x86/mce/apei: Handle variable register array size
>=20
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>=20
> ACPI Boot Error Record Table (BERT) is being used by the kernel to report
> errors that occurred in a previous boot. On some modern AMD systems,
> these very errors within the BERT are reported through the
> x86 Common Platform Error Record (CPER) format which consists of one or
> more Processor Context Information Structures. These context structures
> provide a starting address and represent an x86 MSR range in which the da=
ta
> constitutes a contiguous set of MSRs starting from, and including the sta=
rting
> address.
>=20
> It's common, for AMD systems that implement this behavior, that the MSR
> range represents the MCAX register space used for the Scalable MCA featur=
e.
> The apei_smca_report_x86_error() function decodes and passes this
> information through the MCE notifier chain. However, this function assume=
s
> a fixed register size based on the original HW/FW implementation.
>=20
> This assumption breaks with the addition of two new MCAX registers viz.
> MCA_SYND1 and MCA_SYND2. These registers are added at the end of the
> MCAX register space, so they won't be included when decoding the CPER
> data.
>=20
> Rework apei_smca_report_x86_error() to support a variable register array
> size. This covers any case where the MSR context information starts at th=
e
> MCAX address for MCA_STATUS and ends at any other register within the
> MCAX register space.
>=20
> Add code comments indicating the MCAX register at each offset.
>=20
> [Yazen: Add Avadhut as co-developer for wrapper changes.]
>=20
> Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>

LGTM.

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>



