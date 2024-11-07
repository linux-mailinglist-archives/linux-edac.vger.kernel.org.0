Return-Path: <linux-edac+bounces-2466-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 993A29C04F0
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2024 12:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580BC28178F
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2024 11:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD3020ADC1;
	Thu,  7 Nov 2024 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBRE6Zck"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256CF20ADC8;
	Thu,  7 Nov 2024 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980440; cv=fail; b=SgCPZEy0CRMgm+uLRp9uqOnGwrtaUB2mcquUQOdzloT688cX1Q5jVe8Rbw9gte5IJYnc1gySWLX8sbzCSjQRTljS+B+H9spw15Kd/DghMQxcOK7oRj7vhY4X6vlBymTF8zEVJGWY1i7IYTcbl1BP68T5XhYqE+OVbcqdGXJDTzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980440; c=relaxed/simple;
	bh=TQSuaWjBesOCLLi7fO3/NzabFjvDB/iPMeVYiLtTrsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nEgHmVYLnwo5bD22427M++eDIJF352MWycGrReUaHTZ940JnmxT/1a3fRUfnprFlD88sLemOZhh5ER8g8MooSlNym4o5nsZtp3XKlExTFXl7MM5NenQuRY3nfHwLquBsifV0S3HQqMGl4CVI2JqSNS7fDSaU//U8cgoMcaIbKXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBRE6Zck; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730980440; x=1762516440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TQSuaWjBesOCLLi7fO3/NzabFjvDB/iPMeVYiLtTrsM=;
  b=eBRE6ZckKRZj4UIxBiKzRzo86/2t6Sqd2GXLwt0RmXar4SeCVe88n3Fx
   U7lBn+82kf74c0xxTlX1XQWtTGatsVOQPHhusfuVJ1/njxyVUfzyRxocH
   02g2yGHRxUys3LMr3nvSIXz2r9XTS3+6enMtS+E4QyhUUuPSDWu1hgEX7
   eLb5z/4VvLq1fwb3gJ7lKB1PaggxX7+NLnImoucgOWF1Db25UMqSB1GVW
   u1Sd+dNGq4c+k1th3rm0CfEXBbtfpmC7bOTVk/5SrYk6MgxwbIZc+awDn
   5mYAz13GXhPryHM0CE1PPvY3do7t1P13HQjkAtNYu3hxko72qh8x8bEFc
   w==;
X-CSE-ConnectionGUID: X1mmHn5eS6uQP4qZlJCFGg==
X-CSE-MsgGUID: b2kEUND3QjOJVW8sExGWZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34592987"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="34592987"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 03:53:59 -0800
X-CSE-ConnectionGUID: 9e62zgmySWKifK6823hInQ==
X-CSE-MsgGUID: +BComSkWTdq5PZHKZCY5dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="84984396"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 03:53:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 03:53:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 03:53:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 03:53:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaI4KYIZaECYD+z9NzWhwkN+wxdgpUUWCl/MZidnMG1B7lDd4elPpuex22VFObxFmeGfYwZP/M+1IjGkMd1zePKUGPY4l15MLodUT1HXZk1oJCvFQfIrVFl9Tk1xbp9L6czTuQE1V7RRM3ospbEdYcEgjEmgdtoyfeMowt8R/NVMkq3n9VevY22yiy1MH0Fw4cQ15MgHfsqB+5TpaKGojHe8+wD61yRYRLUmeCis0s2k/QwEESoSJPKuV4whSeCPB/W9RDlgJg/vpTvPKL7PGJbJYGvmghxeZYkI1lWpZc/J152juE9BdECvvBIKzekaJQ9zS1L8UTVRoeiuioTe1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qq4Fi92sncY63A8N17TVM9Eg3EAhRxUvKGRPg5Cxh8o=;
 b=jjxtY8qocg09FN6wanxXB/nADyUayvW8LZBr0Vns52PeHvF892c+yRQFDDEzv2Y1YPDtKvooV2FEncVcy9Yx1NyAG3q1o/KXTFXniE9UCmM+vKug6VRZVKlMle8LyZ7myPQwyXwQN81/DrqZkk4ijaDIjUB+P9KzVes7FDr+8NfKuXhxiPVX2MtYreP1FjV5+55rnjWkH/XLmXdE9Kw1u56Q673/P56kw10wz9uXT0uRU9wNzW30CMVO78Xntdym8dnEKoKRMyMxrPi18H41+B1utkWPogBcPor+5YJdXV1SefYY86aq07MQUwgOEFZa3TRVakfckRQuHhPlBO7a3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB8576.namprd11.prod.outlook.com (2603:10b6:806:3b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Thu, 7 Nov
 2024 11:53:51 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 11:53:51 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Orange Kao <orange@aiven.io>, "Luck, Tony" <tony.luck@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com"
	<james.morse@arm.com>, "orange@kaosy.org" <orange@kaosy.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>
Subject: RE: [PATCH 2/3] EDAC/igen6: Add polling support
Thread-Topic: [PATCH 2/3] EDAC/igen6: Add polling support
Thread-Index: AQHbMEDdOOErzlMS/0uupyaAcmloUrKrtojw
Date: Thu, 7 Nov 2024 11:53:51 +0000
Message-ID: <CY8PR11MB7134A6E8A5B8CFE1699CD9A7895C2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241106114024.941659-1-orange@aiven.io>
 <20241106114024.941659-3-orange@aiven.io>
In-Reply-To: <20241106114024.941659-3-orange@aiven.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB8576:EE_
x-ms-office365-filtering-correlation-id: d916513c-4bcb-4f49-7bb0-08dcff22d914
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Aix654JcXyL8rbhPEs4f7UexdAgw+SdQbGND3qiNuTdbdwk1ndcpd7tHnIu4?=
 =?us-ascii?Q?EYHalpbt7ER82GbbtHV0PsZ9KRZpAeNoGX8OYUUhFkJsGGRAeJmoCkWdqzD/?=
 =?us-ascii?Q?Tqto802howzI02huoAo/fKk5VROMxfqcIkxOf/GqI6I2hGJ4HgxKPGNMc3Eh?=
 =?us-ascii?Q?14a6gHRVs7CWJrq0E9QBt5XUWOG+X5u84NjhyV+EN/R9LMTZVqyewFB7OwaL?=
 =?us-ascii?Q?cHLCDoonI02OmcJQahQBn+94bv+QlUGuvrRH+Y2eJEQKwRWYYmr1QI5dXJCb?=
 =?us-ascii?Q?FYvmp4sXVEWh8SLc0LA2HQID0+m4h5hrAFpe4/rQ/goaH5MtAagMDhZRhhbZ?=
 =?us-ascii?Q?8uThHKjYMAwjWOphEk8IBzrtB89oYTfr8euZa4qPn1LsJkkLa79TIcLZ6XgC?=
 =?us-ascii?Q?vn4u76cYGpcKbvRvcV+OBqAeFZSMrfbuzZZihe8l8N1t42xvSrpAnbpxT6eO?=
 =?us-ascii?Q?TYYFfLTOZx3zF4O6hWFev7Oe97AYX2En3coduv5Vkx31W1nx5bzb/M0SjIi4?=
 =?us-ascii?Q?kuRKI1/1CYlC1UXktG5lTwEGz7OMQs7hZWEyqESC0+KSPqv/k68jO2E4ECn7?=
 =?us-ascii?Q?RrFcLRkcUKUw6Zv24s6qdWVyvfUbNan3Z0Uqs40T23ikWFoEv1B3MQUzoMx9?=
 =?us-ascii?Q?TcQEYB4GAKt49tjJfsAT1yph7g5OADkgmSHsz6Md6lcvVWf4/Z7odOTQFmtB?=
 =?us-ascii?Q?1H+73GjabA/ed/5Qo1oT1NkYibGYl1AJbroTrqv8EoUW4Iaj3X73FdfiZMBM?=
 =?us-ascii?Q?ssPg+SReNP4C5nceBdJ1w2+cm5slg0Kfie+6OQNO5WCJJyNl+TeoRQ8S2661?=
 =?us-ascii?Q?M9z6t8qhwVUtZWt4ucJT/8LJrW/MvCWzaGzmiKuDfT+6MraeXSxBTEy8+Gs5?=
 =?us-ascii?Q?pXAmrn+giBWb+7DuWHMA4zeV/lpI61IH0DGy3LyFMgo5gPofO2HOa0fKMBXv?=
 =?us-ascii?Q?DZK6TirxShXBPLWufQIgGLUBlG2CxAljfRIoy/oloecoXrWcyts49KDHURtQ?=
 =?us-ascii?Q?KjuWnziyrqL9hZVlcrdiLXsOqaRDwr3VomvLZu41/KXzfIfFv2doRzs3LEfp?=
 =?us-ascii?Q?P75zGvD8rx/wLrqOm6Ht5D/4bZimyNHC5p13ELW4Bg6kCFPa89a/37z3vFrj?=
 =?us-ascii?Q?2jEdhrgeP3DTcvfXYqT9e9HvHbuAjJkrd7Xw5yul0Q/uE0yI2izoM7gSxWrY?=
 =?us-ascii?Q?OtsZMY2a04K1dAuEpWto+wm95RyBHaF5J/3kfc4JE2aSJLwbaYmpXT+EOaL/?=
 =?us-ascii?Q?JF0vuWn4QqY9qqiChKW/M8n1GJcpsNKzu8lKQgt61MkXiphC8vLNoe3xOp/u?=
 =?us-ascii?Q?qRo1rIBEjbCIYkc/PACng4M/xACIJ4DT4N3RMkS2tf82SAwZaGsKtqWZCJ60?=
 =?us-ascii?Q?VlmWQow=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?os+De3HXxGXRj14Up0vP6hbjiSo35Rygw+C0gmN6mykudr8/hmdTLhwLGult?=
 =?us-ascii?Q?DEDGksPkxyjRTc5Qxlpr1RXHOlmAD4ly/sqSG3CHe46JENtdSQxUtrMrYjUF?=
 =?us-ascii?Q?po/RDSp5BgGKnwUDB3qxDaBHNxYC0jE7+NmSZtsXU2TiPPUlJh7bwTqbZM6K?=
 =?us-ascii?Q?l/3OiNYJYeTfNabYWg35fQKKIPF4xOe9KqRHttno3+4OFd5YsDEN2Py+6GHV?=
 =?us-ascii?Q?1Xt5RQMDSrwtqgHOG9gkLvrsDCcX9YVT3kLkb2IcBI/KKWhgZE1h8P5pBJ9o?=
 =?us-ascii?Q?Epq24hIQEgUXs4RD+KEfk21SblQqNF0z6MwBSpo/WYyFt185b9HdOFTPrG/g?=
 =?us-ascii?Q?ngkHidh69QrVP2jhLQVyIMvy0aYbfM1pBc4CzKGAFlec+6Ce5Qi4cO7BTjbl?=
 =?us-ascii?Q?HgUTOro2P7aVoxhpREkIEftZWCQd9LApl5CoiK0zOyhdV25XE+N3FmhVAlt5?=
 =?us-ascii?Q?x+DEVwtBBy/Zv+5lgxOldAJdbUJTJfbSWYJbrYVWtU2/1H0qnhzgFRkgtHEo?=
 =?us-ascii?Q?fCu3aFHXicjSzmuBBkt5F9yxGnaG7kSzPkt3dlTxLULe/MvSwL4m+tkKoDhL?=
 =?us-ascii?Q?7AzKoJ2JWkiKB06T9NAPhnAbBY0dshSARafZ1uckUkFwbwbYvt4s4kt2fMRX?=
 =?us-ascii?Q?7BrhVfRzDTbDQOqMlvk2OBCFBDmVzRpbkOGqyElax2tP5zvGs2oeSujgVxQI?=
 =?us-ascii?Q?GE8TVswMCpb7b3qzOHTT37Bkw2ER1pAOl6wN1l7yH5ONNyDcuc+hmv4IGkB9?=
 =?us-ascii?Q?Pie6ZkMaMdX+NFstRlzYAsH1HyJI0eRl5CruzCKa4GoHeSJBEkA1/4ddKrPA?=
 =?us-ascii?Q?znM99W7bXhfbwhNZNXgUp3Ikn5OApx0i9+UzUmsDw85ujH0+quDz+XRdZZGW?=
 =?us-ascii?Q?JO+GJHQr4TO0y0DiDVjwW1cJpMkUIVv8U866jfUVQrOSfy4XQHPE+nvwzbeb?=
 =?us-ascii?Q?8HtzNZfYcVy9AZ9f59dDVKAOR/GMkyZnG3f36Q+wAuR1XzAExSuFCPDBavTa?=
 =?us-ascii?Q?5VOvwrCb3oozfTLWJQ433LQD5bYLbvTIMNSEpupBMZlnyke2saH+f9wSBcXY?=
 =?us-ascii?Q?sxek+u2Z5F9absHtu98QjaM8FMllqWo4LKcVk5Rm3YVqckfx1XUPQsUHJE2t?=
 =?us-ascii?Q?yTGXH7m0Y3IiDHuVRx8Tj0qfuRhJAnecBXGlOwMcsVBaW1TiJTJJW/Bxjf5a?=
 =?us-ascii?Q?o3dziXraGyvYEF6RpmCPBXcKulQYFGyhjEXsnoPrdTystEZKD3baCTkfy2Wv?=
 =?us-ascii?Q?swBNJkj0uyfZfUx0VTVFOtqCtvsmwvJorpXqU4WcQDliZWYmMLDdHrBWKIWr?=
 =?us-ascii?Q?6wyGhyiIlAzRr4cToRzEgSVsZCswx1A0hHtlotWsoypCGBf//dTPBgh2YRmy?=
 =?us-ascii?Q?O6TF/0GKcOcJbds1eYIkHZsuENgEKKqKjBTfdFSfCopQllqYW+Pvq4oGn8tT?=
 =?us-ascii?Q?yDxvBYOPRK3Y4aTA6lpKpfRChGjiy0LQ+rAa3rF6x3O8Pg3S7eodLQEZpPVo?=
 =?us-ascii?Q?JwVdJJDtJLs70tg3qpZFbB16xvEjXwppMLl+9au41QUz3IrZPB6oZ5MeBF90?=
 =?us-ascii?Q?Ai5uNyoTVmwuhS7vCiFS7iM1LvV+6hsLqhfJH/n7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d916513c-4bcb-4f49-7bb0-08dcff22d914
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 11:53:51.5436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPOmrulMpG3XL6fDkf/GFgO+pjxd23FMFnYRF8kRcj4ENCB0b4q/ujnRt2RJuo/na2l55Ix2SbnxrZC4z1xNGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8576
X-OriginatorOrg: intel.com

> From: Orange Kao <orange@aiven.io>
> Sent: Wednesday, November 6, 2024 7:36 PM
> To: Luck, Tony <tony.luck@intel.com>; Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> Cc: bp@alien8.de; james.morse@arm.com; orange@kaosy.org; linux-
> edac@vger.kernel.org; linux-kernel@vger.kernel.org; mchehab@kernel.org;
> rric@kernel.org; Orange Kao <orange@aiven.io>
> Subject: [PATCH 2/3] EDAC/igen6: Add polling support
>=20
> Some PCs with Intel N100 (with PCI device 8086:461c, DID_ADL_N_SKU4)
> experienced issues with error interrupts not working, even with the follo=
wing
> configuration in the BIOS.
>=20
>     In-Band ECC Support: Enabled
>     In-Band ECC Operation Mode: 2 (make all requests protected and
>                                    ignore range checks)
>     IBECC Error Injection Control: Inject Correctable Error on insertion
>                                    counter
>     Error Injection Insertion Count: 251658240 (0xf000000)
>=20
> Add polling mode support for these machines to ensure that memory error
> events are handled.
>=20
> Signed-off-by: Orange Kao <orange@aiven.io>

LGTM. Thanks!

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

