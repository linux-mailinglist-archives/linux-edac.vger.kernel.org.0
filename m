Return-Path: <linux-edac+bounces-3590-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93C2A93BE8
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 19:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640DC1B65567
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 17:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83CD213E77;
	Fri, 18 Apr 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EH0EG37g"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF28F77;
	Fri, 18 Apr 2025 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997058; cv=fail; b=NGGH74oI2pI4VeiBF8LkIxF1iiPBsC2PTqAJrjm8V6OvNcGbXO9wEo5uRrU6sWLNtM2mM6xH909sPO6+jhFmsAEUJv0FfpAzE8A1+7QbT+to+56tdiAEMvPbd1JFMsJV/OxJpCGtOGWMuk1hg1nbaOlGPhxIGVS38sHiqE0pnJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997058; c=relaxed/simple;
	bh=PmES2M3CiCfAeXwAZWfbscfwriMjGxODprLvqlmk04I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=agPYTzc4L4X+2kYsB7tWqrMg9azmfDzIi2rPyuCRXePD95AGqKHfZf2AIS8CdNR2jnq/0NfinsqDn8qGusZDyYGPKnvzoB4slIL7NjEbMqM3mGD1A55nxt+ibbUSeSHTk/ZCHFEVNQI6qcEsEEBePkz1qlf5o+yWeRvhA0+LTRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EH0EG37g; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744997057; x=1776533057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PmES2M3CiCfAeXwAZWfbscfwriMjGxODprLvqlmk04I=;
  b=EH0EG37gCtOtTQH7Tf1h74vHstejo36cg+VndRFyrrcIguQFSrPlEzAU
   YNwYGZKqaGMqseVwzursbLpxXUaK6QZLiDTmQmw5DRi12IzZbX+T5zSqz
   oJ2+/Vezz7bnlL90e/x7v50xHGBlroJs5gW6E8hk772Z2Fb3CAmY+xIgh
   lmpaUKNZoWHiWSlZe0xg64XeGAy0+wewi5M/cKYsebXiQ4MCGUFAOE3yM
   NPXRQ31oQUjsWPs1n1p1xNNkkl+slEZK0QvpGFs41jj0AL9kI59N4msfU
   azdugzwbyS54Quxg9nMIYs4xcPiL1F6q8a8dvxuxBVMuf0Efmp3hv85sZ
   g==;
X-CSE-ConnectionGUID: nuQeitx8S2qe+XItOyu+Dg==
X-CSE-MsgGUID: dBFtl799TDGcP1ny+e5M/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="64035096"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="64035096"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 10:24:17 -0700
X-CSE-ConnectionGUID: +1xoXA0PTkSgKZcnpedJrA==
X-CSE-MsgGUID: F01qtFGwSF2yAaIJQ1aysA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="131463469"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 10:24:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 10:24:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 10:24:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 10:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sz/poMcWf69in0F+xtDWN11QTZgM7Nc0gZk0pVnlgOtekpwtl215N6oTmJo+piaAFprC/UoHNN/jI0/3ChqzoCYVRpF9P+GM8U9vHxDQpxmZmnNe7QQUWOW+7g31YcNI+HQKryt+TscVArggdidgfx23eDOTgp4Wb9Pp78aaFEKVx8rSSx/fD9aq30A97Nz3Pn7vF3ykGM4uvELOT5lQdONtENQwgW1kS+3a0eaRHN6Iep/pKG7yXO1jrYGA4Glipi2zf/8O9YECIn/ji2GsN4FBJF6zgNJum3nQ8o6SsPCCXOhAzqZbMkLx6E39zOUb6hwXr7OyOJGlZNhOO3oy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IyxRAZ97viRyv7JfMyNEiAnKUfX3KYFWVO5dZufsjM=;
 b=j9o/QVA+QMn9WKqr1Kl1VeyOlddw3BALoszILKnQtstMcAg6ez7mtP5Sm+cuF70IJl640j5BPd5YM11rtkS82LrZ3DpiKUNjts9helODRjNXnr39aH4PW4okFbd0bGXTTaTMv1ax9wmL+sFv3XtUYFXGHopkKQSUXYfUYgNaZ1yXH6Hf5tSkBTaRFsp1JZtDDbjebM09K89vr0iucYp3L4MgF5pMbtdVCbMI3JXzD3iViZd7UBF1HA3f8P97ojxteEUSud2ZVRDniyFuiN+Fbyf5PV9jOvDZZMEiX4G1NRJ5U4kEF2Hh1MPCsqZ1BPDm4C2MqRy5qSyaHLJPFULEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 MN6PR11MB8193.namprd11.prod.outlook.com (2603:10b6:208:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 17:24:07 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 17:24:07 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	"Lai, Yi1" <yi1.lai@intel.com>, "Xu, Feng F" <feng.f.xu@intel.com>, "Fan,
 Shawn" <shawn.fan@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] EDAC/i10nm: Add RRL support for Intel Granite Rapids
 server
Thread-Topic: [PATCH 0/7] EDAC/i10nm: Add RRL support for Intel Granite Rapids
 server
Thread-Index: AQHbr6qZQVYzOQ+SWUy8DMEFqe5DwLOprcrQ
Date: Fri, 18 Apr 2025 17:24:07 +0000
Message-ID: <DS7PR11MB60776F2FF731E8DE3D15D309FCBF2@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <20250417150724.1170168-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20250417150724.1170168-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|MN6PR11MB8193:EE_
x-ms-office365-filtering-correlation-id: f47d808c-9468-44a1-dfbc-08dd7e9dd302
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PCNpo+86MSBQctyJxr5biNywfq90Z30EbNm08vBb4C+U6SkChgdhtyLKfnJW?=
 =?us-ascii?Q?nSzglcneQNKaWAClOIZuImaKirZiN0p3LkJb4JpTPD6bWdDVDS48wrQSsPYX?=
 =?us-ascii?Q?81xKsfqIeZ+V76Ub4uV2TIOr1nQcjCzBVfTA4fKG5Sn1wr7f7jLr4ghFf9NT?=
 =?us-ascii?Q?veXKuMCKxWguPA4vD+Ouzj/Favs/k75996SQu0aXkrsw6tP2mbDs0zTHey//?=
 =?us-ascii?Q?OXR+JgzkwbmMg9iLdNWYdvRmApTvTg+qLjx68J1ZgMQdau6AQ6HDbpbQsuDC?=
 =?us-ascii?Q?R9EbyFL8R/wDSYdcTZyIWXLWa5J8FHQMG6DKJHRicyQFAmCQWNcIXw92Ythi?=
 =?us-ascii?Q?MLKRL6eW6rgzvYqgT0aGbuIU3/0hIK5O3zchbvZjoxgl+nN5UfaAy4pJpfpv?=
 =?us-ascii?Q?FCOWLc61FBTx+ht/bsU8UjsVKzp4OX0SBP1LVm3vxpn7+AjmLJRyXQ7UL79c?=
 =?us-ascii?Q?fMsGN/D3yqgHjcnq7XuoH39Xv5bkIwbARUvq54em2vEyqOYgeULky1p0Uw3v?=
 =?us-ascii?Q?MqLcdbulJe7w6VRyzBRHU/epjM0KA4Fh2vIaFCXOtvMIvYXLyA0g82o2eagz?=
 =?us-ascii?Q?8cuL79RGsJpLtf67TKye8l0NRdjN13+pvypIT7vnCDqJ0COiChGimp6bEMP2?=
 =?us-ascii?Q?pC6XIQN5Q1vKPfySa75QyNwb+qrvp91Jlhbw9nktoUbM4zFkCV0OTpCnSQJ5?=
 =?us-ascii?Q?LfMWifkQ2MmL3YtJT3fWxH1NDBr+2UNIEvR8beyd5mp3qtWxkyQy2XWc8eW3?=
 =?us-ascii?Q?4kpjShSx/6B8YnHnrbEQBUd4CllFY+dwoASj4cKkEBzqi9ai/YN3G6M2Wtnu?=
 =?us-ascii?Q?pW39GTKLNV5Ef09sZmfjRAFgoy82FXXgEFi1E3MEcRggG2EROa4hQVGqUyhb?=
 =?us-ascii?Q?dKlG/9LXSTjP46N8iLhmexjKn6wooxAmMNJeOvvefdngxQgl2XkIFIQ2YnV5?=
 =?us-ascii?Q?gd+banBdiX9OPc7lGUnpaEDUaLTZ7zKqUcK0XzN4cDZKqpA0dB4/BYGmWPRZ?=
 =?us-ascii?Q?tWk0N9srle+omKHG3/nybTpENkt5S1P8s2BrkBzT2CyDWmohdbyL1Zj64b7w?=
 =?us-ascii?Q?ZjNjdmukSGiWxuVfOZh97RKdOhzbkG0jsDmVlZIgKIgcyCojXVfmJyBknmib?=
 =?us-ascii?Q?2Spj2u688h9+znZecuDT8t5GsT+RhaaY/CL0/hLFatifb3SSjYawyhPZh7s+?=
 =?us-ascii?Q?whGYnzUKk/dBVLBq/Xsid+iHF3yCPXo0VIiCBuRaJWYPM6eME9oorO3WGd59?=
 =?us-ascii?Q?/wwX6qxGuJiTFU5PzPoV/fyOKvUWsz17v7+ugZFZfDS4JEc++BtnGKhBFAjv?=
 =?us-ascii?Q?HigK1paoU8JwBDOg2lqywhyWNounlY/tKIz9tGfRVcwDP7IErDXIdc3RqCLt?=
 =?us-ascii?Q?GJbVUW1npBabGTz91kR4BEeM58999kEQsWQTLUdt+2uwtw/+0Tl+VbhOjA6b?=
 =?us-ascii?Q?1CnhUYP9CCdHdHGjDvHPOIuCHOSU7UH73amuT6WkyfkZlkKKhTMpJQs6sGtq?=
 =?us-ascii?Q?P1TYSjiV/ae8iUw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p3EDYIyP3OhuLZq727QjTaahz2UXtOalSYnco6K9vi72vofsznDk7LQlDpE7?=
 =?us-ascii?Q?o9S6APGj3kklPYw3ZdMQmXwTYILnrHYYlz1jqQvUSp0P55waOGQ/yRT/Zh3T?=
 =?us-ascii?Q?xidwgP4C7HhRyhoWx/gY41069Mh4/XMm9W2+BFfpTfK829pr5KP9KUq2u2p2?=
 =?us-ascii?Q?VvhpW+PqHHh2u6uVygVEqz0Qm9yarKvoLhHENDx6Lc+bjAzaM55HFg2Z0sz6?=
 =?us-ascii?Q?LQ4MWCJ01b3IvsaxtO6B7XcaApA/TYHyEiKMmqtETYJ9sLiSkAg6HftTPkYq?=
 =?us-ascii?Q?XdKJgdX/nDfVU4F1ZlfIPqegoCbj1eBhRZEClcQ3j/HbHMiEQk6/ReOtkolx?=
 =?us-ascii?Q?SbeD/j1FD1jIPM+L5khVjl9jSlumdhe8oJ6WL9565ZtI1eXFsSZ54exPhf+3?=
 =?us-ascii?Q?TVbPIX9iF9a/i5gySoJFZ9zovP66zWMX227VdL6IR2ITDfjvp+xedqYXeNey?=
 =?us-ascii?Q?yYxLzdunnCMOA1nY4rcUSM/rQ/rIyJlcc1NeTaKkJY2oAAjTNVKoFkQcxipD?=
 =?us-ascii?Q?8H26YBVDcZA7wboWYIj5q8o+ZFS6J64HJfZt6W3CQqDI96DPCKuQi5MJmUlF?=
 =?us-ascii?Q?qLMM1fUoA6dtwNwByGMoFy1c7CtcH+VL9lZ5k4CILyeHx/Hv7+bgT7w/OMjl?=
 =?us-ascii?Q?1uGuOQw7PslG6/r44M+4XLxT4Je3KaW3Gw2vDEb/FiZADHSyzStHYeLhNPg5?=
 =?us-ascii?Q?6z8kuviDRBQO5ZoL/dZsIBZGZegVZLRGfJ8lHsmO+d5k4RF7MVoLoConh1mR?=
 =?us-ascii?Q?/UEHI6d7LZswJcRA6Z0iLauH5w6S1voSVWJV8UfJ/uesc5OOdZNysHyNL7vx?=
 =?us-ascii?Q?mjHCBiywSI/M1utUUAQsLrYpb0bYkoJ6+trl40Mhf3+1BtgAO1MXPUXw0OjU?=
 =?us-ascii?Q?mo+rHAvxM6eci3ZEzpv+8upGyCtkZWX9pTYsx/Sc29HJ+2W8yuZF/KFCecFS?=
 =?us-ascii?Q?R8VL7YQuC6o/D/wAWB7S1SgrP4JwBQ3nVEwb46O0AUjO63YH3WXiGYRcVEdC?=
 =?us-ascii?Q?hIlT/ylk2yFCr8TU4uecjaPHPC96XkZqtvst/JxDQq7KHXLtCns9EfGSk6TW?=
 =?us-ascii?Q?rn3xFIf3xUkBJiC74S2ZcvceBvjij486a2haZI9Hl7pXBPzaGUTaMh3DktSp?=
 =?us-ascii?Q?spNeypS91FNP4bwPiG5L+vj7+vqpa2TCt+7vWpIbGLPBxpjFdyi8A7APDgKJ?=
 =?us-ascii?Q?i44wySRXVWF24ISR+WchuxlMkSDHyJ3c5I8NaDVCxKqoARIwuBXKZPUVeX+j?=
 =?us-ascii?Q?dx9PYIkwRwlRYmgPntrb4jx+2KPJL4GgDg5RSL944xhVfcHq0oi2hR4BSS5z?=
 =?us-ascii?Q?vzzjbJX8wPp0lZNyf4TkU0BAcB7waDQTY6KHFoJynTNvd+ZAG4CZtlkrUfxl?=
 =?us-ascii?Q?syQD4bJtktMiHeTeNGa+xxVEBVLVM+kooR/htRIfgVnA5/ccso23Qc4DOmhg?=
 =?us-ascii?Q?31VFjcTblPpSVZgUhLxK6Q275uZlDUjB2uejLWUS395qDyDqo0RS+hoVy69T?=
 =?us-ascii?Q?wMB1zoUq+TVCo8DkgnKh9k/9N+0w5DjhVbzTWJVW7Jp5/4UZLFJiBPrZGLBO?=
 =?us-ascii?Q?ZBGUPeIbbba7AUF3WQqCQBWlqstzuhhhuwY0z38d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47d808c-9468-44a1-dfbc-08dd7e9dd302
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 17:24:07.1189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHAV+xp3/pLNPK5E7rX0mJXuiaBIOanmLL4QS6Scz5e1kF9BCCgNPcYBX3TMoCxsNZfurTBSfAjh4qBXgvfPOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8193
X-OriginatorOrg: intel.com

> The RRL (Retry Read error Log) registers provide additional error informa=
tion
> during DDR memory correction. This can assist memory DIMM vendors in isol=
ating
> problematic cells within the DIMM and help CSPs predict uncorrectable err=
ors.
> This patch series is to add RRL support for Intel Granite Rapids servers =
and
> is structured as follows:
>
> Patch 1-3: Bug fixes and cleanup.
>
> Patch 4-6: Refactor the RRL (Retry Read error Log) code of previous gener=
ations
>            and prepare for Patch 7.
>
> Patch 7  : Add RRL support for Intel Granite Rapids server.

Applied to edac-drivers branch of RAS tree for next merge window.

Thanks

-Tony

