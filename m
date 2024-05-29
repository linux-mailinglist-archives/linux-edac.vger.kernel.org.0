Return-Path: <linux-edac+bounces-1150-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306EA8D3C09
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 18:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDBF1C211D5
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 16:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14E91836CD;
	Wed, 29 May 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mziepsKl"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460E156C61;
	Wed, 29 May 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999295; cv=fail; b=D/CueMEmYpVmySnQUKJRfEEBLcb+2vG9CLoLyffFwWkFydipCSvhDtNDSZe+8t/+GRJexCfIGxS4pLO2VZLIVZsVFe5wzhTEMCyKC3F/+PzJuXg82Yr+3OlqPrbsnoCC+LoTKPOOfonsuKh1bFft2872GLOYSvc3Yg8Vy77QWKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999295; c=relaxed/simple;
	bh=Vur/8Pa+gs6ZbDniFzXYerQC2JjfAB4zeDLQDpry0iY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qvKIs1gSzCgW1CqRe+IENTmbWJwEY93eoJs1C32lus8HEWSs1nTEF6O6yp0ey5Q8EzuI4vAAcVodtzJLf2p+wqyB7nwFRsWpyGmYXEJEn+ik19LiXJMVwA4qSNoJKGs1gcH6Pov24hmJGLX3Jrkn0MqGrZw+9ZHyHd9oR1OQ3FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mziepsKl; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716999295; x=1748535295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vur/8Pa+gs6ZbDniFzXYerQC2JjfAB4zeDLQDpry0iY=;
  b=mziepsKliCYNfDEH8f7fvoLShU+j5dvaxFyTZp8lVlkNiahkV1WjxLaa
   vLSiMYHfqpojujLKbk8iI7hm4nhGrG0uThOKj5agtqiN0tJFUXcOOAjhw
   BfGj1PqrDOGyNd75DR5YIbQXMvnQnoqBqsZZVz8wVFT1dPs4NYpTqqMYD
   EWoNqdLndwCwrd6KSOkoMEXn+RlotXe6O/+xetVl2OZ8hQpNs9I3p9fMp
   Ej4Mq+43oHSHfIwKBpI07TgZApsH3pOxdOJ3qCsVQgBKhrtPXbSywrUqP
   BedaCxsyxvqrPBESYqi/eiRySMXxk1RszyC2og1iqAbpsjAbqJ2unQpJz
   A==;
X-CSE-ConnectionGUID: /UiK77s+RaKFy5x+FPwaPA==
X-CSE-MsgGUID: OcWYf3gOQBiMcsRRb6nMXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="38803017"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="38803017"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:14:54 -0700
X-CSE-ConnectionGUID: oUuwLor8RL+222qWS/54cw==
X-CSE-MsgGUID: Rvrpe4FzTkG6vQx36/P7bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35431168"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 09:14:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 09:14:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 09:14:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 09:14:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 09:14:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgR8jOTQg1gSHjRsBMDWGIRaL0Uy9dK6YdWEDpt+wucWvp2yIuGlJAgnrUcu3Kecx1uTgeAgtLmhoDHP2ndNf5dch2hmuH96zBCtdu+KmBZs3QLtvhZZSh4aWLgDnCojwIqARvtbiVcAQebA1QJqwOPhlOwfce2yFxxsEXFSAktJyXJnq7L4FCkViubxMyIotA0KGnhZJ3j6t81l5bimi4zdkoz5uuQwp4gGWx9cDIXZY5L/8YqEYjEGTxWiUDQ0NmApCTa4rTrPC0citjJyLZ5ndTwuUJbOF9cbuMQ5VzSvE9p6/zkk4ZRN79AI8Nb8WhZznKnkG4wrJvyYiqtuZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeddYPMfhHPFqC8bblHRVVzmF0tPcTysjUlG+hBDPK8=;
 b=HFW2rTg0gcwu6Ravhl8MvhUQINMZJB9Bki7hkayOlolr6Xn2XwdSwPx6k0u5q7JMvKJ0rBtJCSkMFNNgvcZ95ZTIHro5ME4DJ+/dZOoJ3KTq6PEaWvWWOnlpzhvQVYh+KKKxP+9CVV2kndzTRGszUwVctY3pxsZhRgiIzwG4KKAEjoVCt4Arsy8BvomFyuMUi81zGToIJBE8WBkPo7JYssSCHNfLPnChFmHi9aljJYdieIKW/7dSfOhdPhiKOR3slwrJAp/K5HD3UgcAcc4z/zXU2vH6XMr/dNYFftl2VaYcrCRvslVfz5zsvcx3m/qXywki+LD6hxXY9QS/ss2lnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW3PR11MB4572.namprd11.prod.outlook.com (2603:10b6:303:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:14:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:14:47 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, "Zhuo,
 Qiuxu" <qiuxu.zhuo@intel.com>
CC: Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	Marvin Lin <milkfafa@gmail.com>, Shubhrajyoti Datta
	<shubhrajyoti.datta@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC, i10nm: make skx_common.o a separate module
Thread-Topic: [PATCH] EDAC, i10nm: make skx_common.o a separate module
Thread-Index: AQHasa3a1dpIalxTtEymaZnJ+xR+PrGuXnyg
Date: Wed, 29 May 2024 16:14:47 +0000
Message-ID: <SJ1PR11MB60838B76940188104D57E53FFCF22@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240529095132.1929397-1-arnd@kernel.org>
In-Reply-To: <20240529095132.1929397-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW3PR11MB4572:EE_
x-ms-office365-filtering-correlation-id: 87f13a56-e969-41f7-f895-08dc7ffa75d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?woZq9srHQ7NSLMSZiaVd79udgSe6EYfxEDuwcENLsqZbHOhUTyOGEywB3/cK?=
 =?us-ascii?Q?9ETCnhWcEyrxoWQ6FV/wt+9G4u/g6Ya6LxTyNb+6KXjVFlyDlgx6lYXuH/rw?=
 =?us-ascii?Q?v98s0T3pTRGWZBSOnuH0O60iwcO+bQWFwfPxbZgScjWf8BpUOAEuTZBkLcwq?=
 =?us-ascii?Q?ac9eoDqnvC/BmOqt19Bj6tukrPIz31p2mm68xZNaj/TIXgWh+/uL3mQaD0QP?=
 =?us-ascii?Q?eVl52P1Rw9W3LBzdqNQFsj37L8I5HLqfG8e98EYdpy25JRdjizZfb1OZCV5D?=
 =?us-ascii?Q?KsGd+ldjQg85Csaa/4bcaWI3FpWG0AgSsyRqcpjeiaIHs7x686xPPmtt+Z/g?=
 =?us-ascii?Q?Wt6pVwolNE5Dm17pLDcyTn4U8h2/kFC1fqrIKPIIx5OmYJslLDzlnn8zMVXd?=
 =?us-ascii?Q?PlvPmAf+Q1/gqyCJCQ9hMCAG8/CP7zhIZNPThwbkbURrnxrNHd3dopDUe04d?=
 =?us-ascii?Q?cubkd/sEBIlwvY0Gle/1Sn4+ZTcBk0TYnt8x9oP3AA/x8WvHVkCP8Sys7WaI?=
 =?us-ascii?Q?iYwvEYFj0ahIUSHwYfR1WYEX4o4Z9w2nUuG/52oxL1dSlp/Rx+9EaW4EYOHq?=
 =?us-ascii?Q?xCVxxSBrzEjmcV027E2s7Vy6Lt5trGSOm5Q6kcZFyU9iMOpCEpAx9wAtrvAG?=
 =?us-ascii?Q?4IcHRvVsCgJy5E/XoOTprp9gAcKGXRi0xfOFVRFUYqsG932T965/BIX9OwkL?=
 =?us-ascii?Q?vQVtNAwQD1D59IDgsW0WPgZJDghfSrYLPC1zHNk6mNMRz+2PBRrKDWYTaw3V?=
 =?us-ascii?Q?clTBemxYENDhJKbZ+Pi6b26diaDJcm99CqvET9smdiGQUBgH+e+tcpUUt5IM?=
 =?us-ascii?Q?uPznaQCEPZp4R7V4jJXegoZ90g5YMziWx0JeXJ0Q62HupsElVXGKq3GO+Ack?=
 =?us-ascii?Q?V/Aa1QwuIy/zaphPlat3FblBpqMd5T1zo4CTLlZUqenriDfeAa5dlrsqb0N5?=
 =?us-ascii?Q?6v5q5QYe8QliC6FkIk6moQi05vOS9ZcGMl7KixSrp02z+u5X7TLs1HUmv7h8?=
 =?us-ascii?Q?2hc9JLDpO0mtKuqEYvhiuCEoSyN4/tRx4wb0ZKqipzira64sIZ+im/+UtGCr?=
 =?us-ascii?Q?hjnVpjf5KsnCYFAZMfRAQ+0J0DZ7zIOB592Xm394AVhy9gFXbNHHztIFgx1j?=
 =?us-ascii?Q?KGVA09ipyXKcZW0Tzg9FiA4GR417VEYCs3MvSg2XKMB91JcOZArptw6mTuWq?=
 =?us-ascii?Q?P/FmJgdzQJBUNfOlOiT6sCk3RaGJ7/PxYBYTLj1v6psl8LD/Uexr8z3vz83n?=
 =?us-ascii?Q?slWOgC9WnTfJhRE6w5I0rVJByGnqGR10mcMcrMaww05JO+ZG9Tyq+noHJeXk?=
 =?us-ascii?Q?OgKzsMMWuPIA0XlUdFNliozEUTTvqpGYoN9WZB6at2rdig=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U//VpsgX66oRc9BQuZmAtvTZXYYohp3Ko1clAbOEQZ1hLHq4MU8/rEnakJG8?=
 =?us-ascii?Q?xMiwK0caSLJkmb/EbYQ4MgLMz7gSNO/WFJtGiaYt881R6ymdtwVy1ER/c4AJ?=
 =?us-ascii?Q?TNnT1W4omZSHd7GZHB774kuOM8Dy442OzZ3jfBONeWd3xkefcVNdMc7t1G86?=
 =?us-ascii?Q?qDMpUmJooEk5zvKxkG1g5djKrN6wXW334vgtLC2WUiVP+KxJAegi+isb+nMA?=
 =?us-ascii?Q?3R7zjUbprs5TLdpRQGXLXk+WDaqjLxlMQkyxvbbgrsxQlxjGZ7IEgOROswwo?=
 =?us-ascii?Q?w1s94Ut0M/8r0T3dJBZ297/oY6hkOsaxgQIHWGTzSbgnodRbpu9clJ3afWnF?=
 =?us-ascii?Q?nADLpXyXhVzhCf1Xk+dvpuKXpepiXzumJgeVrMJI1p6QHuoPRGGIvCsbRxRY?=
 =?us-ascii?Q?09cL0D98ctDufUgMB5vPAlBSvJweLr5NXD3OjxeYEAts025bAuj4gJUNEO1X?=
 =?us-ascii?Q?p2k3AhxHE/sHYGmIkMAhwZ6JCVdji75rspT32EXx9V9CCLf5ftRrHw7Vtpue?=
 =?us-ascii?Q?H6Xwp5HnkfZysVcxWh6e68Ov/FyVhh+XUqSeUB6xw3TuJzDS+rrzEKeJT8vR?=
 =?us-ascii?Q?x3TNwoIHKzDOFzBBQxohANWFkEZBQy0gQGkWLMAF9e7YqWxxYooar109OoGm?=
 =?us-ascii?Q?kOrkaQiwWQE5GiyL//KIuVWX9oT7j873Fq39bvxa+xXWBq7OEWghsPldyXq+?=
 =?us-ascii?Q?q5YjlbsUo0n46rOYyRfOQhKbelO6UsEuJ1uR09cZp+ofJ/sgNYXeX5kQE8AM?=
 =?us-ascii?Q?LRcdhYIp432uQC146evFd1Yy8WpQu3PGi9gTu7QA2q5L8dtudYdraWDlNF3x?=
 =?us-ascii?Q?peh8t+5sy90uOHq0PRBHKs1k0TeB8YcT4pEIPgg2gRQcHz5yLo0FHCOCJJZG?=
 =?us-ascii?Q?MFBviKEcVDy5BwqrvQQCTtmiFUGvvW7ztYOVAxqfIff4Lf85w0HqImxEdJw3?=
 =?us-ascii?Q?fNC+kPnUkj6exgmJfgWJxM/5WkFBBvqN2Mt6Hk1b7TOlbZgeZo7o+ETIQ9I0?=
 =?us-ascii?Q?0LnM9KR3Ne4eb1dOqK6gzJEvB0CEjDWWG7kXCZNiHlXxDTvl3h5fBalwZJ7I?=
 =?us-ascii?Q?wEoV5N5r/noO22u7++A55kFU4/e7urSBErjdOniTpVZPM+fk2YZQJZO1pju3?=
 =?us-ascii?Q?zUgJIL07eLMYfCz/jyoMV/CzbDgMm9HViUwegAnUBpuSP/u1KY6qwnnmIjqG?=
 =?us-ascii?Q?S4lrUS1lueELipp/UydFwRJrpKUkSpYOEW/vhiq1E6QX7YzimQ/6RLBjrkyp?=
 =?us-ascii?Q?6yIpM/3nhtenL1cxuMnTXnIkUhs4oi0JUwxEcc8UrcpqlrrSrhFMDihjeV2e?=
 =?us-ascii?Q?WmpkCexs0WJdtINXrC0MvlLIGuZpxC/csUnHkRBys9sPJzAx2BgE2qaFYFOI?=
 =?us-ascii?Q?ogNDmdSvQoqENeEEknzZZzqB07ix7t5DP1aPGPhOYZBuSUZyLsixwKpf6JBG?=
 =?us-ascii?Q?bfZF0bQqKWGHWFuOS6jKpqoYJHi+M5DfJhgRKKMlQU8IEEafQlPrCpitcSBK?=
 =?us-ascii?Q?Jkv7PbqIqrhD43YcMWRzhbdKaT+mcrtfpTyYL56NYqI1Xeh86BgUfvXzrG8k?=
 =?us-ascii?Q?tY8oyq8COMFsnZvthNZx4JlS7xEGeveerUuyE+ER?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f13a56-e969-41f7-f895-08dc7ffa75d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 16:14:47.4585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUN5goPnuWT6DLzDy1Kh5UwooH/4RGxMFBNdAE/Ri3nEpr4K1gx2RD1mEoaNuiZ/SSMlGYKKfVzQViuuD/MvFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
X-OriginatorOrg: intel.com

> Linking an object file into multiple modules causes a warning:
>
> scripts/Makefile.build:236: drivers/edac/Makefile: skx_common.o is added =
to multiple modules: i10nm_edac skx_edac

In this case there is no practical problem from this double link. The two m=
odules created: skx_edac.ko and i10nm_edac.ko
are mutually exclusive. A system may load neither, either, but not both (en=
forced by the x86_match_cpu() check in each
modules init function).

> Make this a separate module instead.

> +EXPORT_SYMBOL_GPL(skx_adxl_get);
> +EXPORT_SYMBOL_GPL(skx_adxl_put);
> +EXPORT_SYMBOL_GPL(skx_set_mem_cfg);
> +EXPORT_SYMBOL_GPL(skx_set_decode);
> +EXPORT_SYMBOL_GPL(skx_get_src_id);
> +EXPORT_SYMBOL_GPL(skx_get_node_id);
> +EXPORT_SYMBOL_GPL(skx_get_all_bus_mappings);
> +EXPORT_SYMBOL_GPL(skx_get_hi_lo);
> +EXPORT_SYMBOL_GPL(skx_get_dimm_info);
> +EXPORT_SYMBOL_GPL(skx_get_nvdimm_info);
> +EXPORT_SYMBOL_GPL(skx_register_mci);
> +EXPORT_SYMBOL_GPL(skx_mce_check_error);
> +EXPORT_SYMBOL_GPL(skx_remove);

With all these new EXPORTs ... perhaps drivers/edac should start
using a local export name space?

    -DDEFAULT_SYMBOL_NAMESPACE=3DEDAC ?


But maybe a better fix might be to somehow tag skx_common.o to tell the
checker script "It's OK. I meant to do that."

-Tony

