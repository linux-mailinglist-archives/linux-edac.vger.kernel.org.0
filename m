Return-Path: <linux-edac+bounces-4016-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55134AC6A20
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 15:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EC61BC28C6
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974892080C0;
	Wed, 28 May 2025 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fh5KuRXu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD357E9
	for <linux-edac@vger.kernel.org>; Wed, 28 May 2025 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438203; cv=fail; b=DzJ683/OTslAtxg4GdCPRhf9BkKhsXBmj0NtvpfPDDn18rUaACbhmEN4KTCSq9yrOH9Wn5dkwUGtgXeff5ZKv4UcvZlGabvSvr/tIwhnj23Ycn3S8R3+wS+qKfQdtKy6m0KcLC7RKIVJEsUB6WzM1O8sad8TzNTHO5YcCg6tiSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438203; c=relaxed/simple;
	bh=mFkN5GIzPVrwXIUCSKtIhfTBJFsKSphjR9rNkqmroEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gi6Nv8rb26ow+ljR78bsbdahN7M2+0NqHtFk476xH5x82uC5tsgW+KJ46a3YnYpiYU14fC/rYIf/a7euHPNg13mN4x/e/3/mGBEIBq8N0n5xiQWLpw7H1II94oX8ds9r702NTZZP5Yzxnj/DFPJthZ+iQjYKrKTrRUuttKBbYw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fh5KuRXu; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748438201; x=1779974201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mFkN5GIzPVrwXIUCSKtIhfTBJFsKSphjR9rNkqmroEQ=;
  b=fh5KuRXu/4GSNu+PIvqny5NPmzsVfhIXzEiNZAnohroQuspfMh32MZFe
   JlTtNxlTRvRH2vn56i5F4w6ajB6g6bD89r1wjTIYDnxf88iR7mSntAKMA
   Oy1/j9eSPDmpibG+jP7h5s86+cuSo3HWfPu4bUkIaM324WribYVQeBl62
   mSpnnvDEcx1CARO/cEjDaIWr39G+s5e/S6UIXDWaLocVyH/iZ7EOq5wW6
   LUX4veDiaa1vFD0Ba6vM7pXF9+M/Jh11NSqGBqHKlU06D9oSWd3clE/83
   OdU23zMSMydnVoxODcU4eJz0b+WSzgHv6uqenFD34RUEroo3xuU1WYCWo
   A==;
X-CSE-ConnectionGUID: BS/yAtwrTc6h5d/Y9cGKng==
X-CSE-MsgGUID: 2nURKbIaTiyORy/dGElaEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="67877316"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="67877316"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 06:16:40 -0700
X-CSE-ConnectionGUID: ZdF8zwWLSDCrG8F1y1fHkQ==
X-CSE-MsgGUID: CVnaPAwNTe6w0HbLI1izPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="143153973"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 06:16:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 06:16:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 06:16:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.76)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 06:16:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AE0bytEUujrnnYSeIJBT5uSlvKj8KuxHY6xAC290LfUwvWvksw+O2X4RvZoIvUbxOZFa/eJ1R033IpZI19LopcGlyoJskaZXFkp/H4h9p4pA76Z54zhcc/pvM7AyC1xmH5ZrCWA+VRtTy9gy7ZxCusNCTxpQxF+rmxqHZ+IVIR0fKCwUZCFFsw573Jd9ZP9c6H4w8cL/kxwfr8DbKRHqD9TrlbN+QbtuG5wvlrOqVwH3nWTZfOYb4pOBE+xkgpBfjPAJqp2avqTXL2cgEkrnnEpBVadxPFLtpcpLtzYp2CK96f7xgBKn6rvQ2ppQOIsfWnTxhxNCqxxHDCzTT6BXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHc1yz0A+ANKoZmBak6G6T97tfzddGieAiyhHU2sDHg=;
 b=fGyE5/LkFrirqlwHD20BDG9o9+FZisCweS/EI+GssfdLzsKSa6KGIPnXEsMzX8W1KMnomvZpYKYYG92ncJ7fEEEpOFKPh6L50Ojd1GF/Rqec7Nv1nv7nPvQhBuACr54ju1McB8xK7ehlNgrOdX0V4o9ALNlwmGx4j7xX0TLH7Zy2IexVi0MU0uGJ3TsxccoouU6golSDsrgipJlyJTGXaoYoxjXdT2g2aQlEpvoNjQvLbcK9hEhxkndGIPfynmXzoWB17hIx1p3LwwA69PRX2mk1c7ot6xpuSWL+hTAPcteJU9wTc/vtOqs1YHhrtDwo5di6HZEnD8QTmkI30WQrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS0PR11MB7788.namprd11.prod.outlook.com (2603:10b6:8:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Wed, 28 May
 2025 13:16:09 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 13:16:09 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Rex Nie <rex.nie@jaguarmicro.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>,
	"hunter.he@jaguarmicro.com" <hunter.he@jaguarmicro.com>
Subject: RE: [PATCH v2: mce-test] random_offline: Fix 'syntax error' test
 failure on AArch64
Thread-Topic: [PATCH v2: mce-test] random_offline: Fix 'syntax error' test
 failure on AArch64
Thread-Index: AQHbz44y6vzDSKN4jEeh7lSMSVAMZrPoBQgQ
Date: Wed, 28 May 2025 13:16:08 +0000
Message-ID: <CY8PR11MB713460180A89FCE6F8289A368967A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250528050345.380-1-rex.nie@jaguarmicro.com>
In-Reply-To: <20250528050345.380-1-rex.nie@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS0PR11MB7788:EE_
x-ms-office365-filtering-correlation-id: 133d9303-ab7d-4879-ee9c-08dd9de9cf7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xAzg0uG7MZt4QuzvsB0V8PB8ZoVVaHFRXh85qAFHAPOAbR05CgDL+3M33dya?=
 =?us-ascii?Q?MY3FmGvsHj/Xe3bGwFsqErQDrQIzu9pwo4qBh8hjSOIG1dCbLTWWhM9/6OBR?=
 =?us-ascii?Q?zz49lSOuJkpO5GYq0elvec48aIn/ZiC+9augcmLm1L9sSAqNBe4XCULkuGt9?=
 =?us-ascii?Q?RrLYIkcWsAnz+WoR0fa/IXT8MN8ItNN4gY89NCEzOplkK0p3KIU6lLV/HdF/?=
 =?us-ascii?Q?yJGxHD/vqdpDtvbcmAZUhocv/G4BhV9H0qJOAUguVg1rNQvQi+ykMFDE9qmb?=
 =?us-ascii?Q?OZs8BHmSRowm44qsooDOCG67S2N9N4mAawNFMEbrxz3kqWxTcG/owoM7jsT/?=
 =?us-ascii?Q?ezo403xKwQtKk8uxgWIVdsdNtiAPNUOR6R3K3LmO1w97Si3p+nz8lM54Wo0U?=
 =?us-ascii?Q?vD86atZoO/nEvges7wE05FgXBcTZGbZ0qadIXlgfkh9YgNqmuIj1LoJ2phg7?=
 =?us-ascii?Q?espVHiuExZVSrYncytkQd8D/xpIXTGf4mE+nWTGrXC0dE1DamQfCFn4OjKPj?=
 =?us-ascii?Q?SAahBa2EbAQowC+W81k0Qpr51hPW6TOoyjoPwWVUF8nkFaDRwW2RRBWzCZyf?=
 =?us-ascii?Q?01L/LKXZnzXhqhiLFAHw9H4Rd/Rl+eXVoePtAoiuzJydnX4tyJpgpvFG8FYR?=
 =?us-ascii?Q?FxQgSsV+CRGX+58RfIT7dgZa48EIdZOdPuNhoRPYXP3QM8jReZHV6YiVtX+u?=
 =?us-ascii?Q?YJI9seuju9L3Dxp0YJxf/mspV58nRLibHI2EaxaMtP05azPG/2OUyek5Ku80?=
 =?us-ascii?Q?MOQcXelVBAZnF6MDMSZJPbitlM78w2a2VjNcpmtVqPwJ+iUHK0ITfmKBM2gA?=
 =?us-ascii?Q?gvjW3QPLKFD4yL3PQkGbn2Hact+gkTl+2yTd+FtqjnpQk6UnkZfZ+I0j1Iqc?=
 =?us-ascii?Q?USJd9mETgR+CTJZIKE+QWWEAeDzFbRe5gohlr2QHwlICMktr9NgFdaD0JXj6?=
 =?us-ascii?Q?s/fkgyM+Mpag3keWC3/sw6k/8fD7F8CGH8mKmsqfTximGpJPOpYzN1AeV92g?=
 =?us-ascii?Q?Gjof/LzP0+BL+l/jlFP7FydnR6nJyuvD+nit/XZ983CqUikLVHzsun/ZKMRs?=
 =?us-ascii?Q?g5ku5GPV3Vdrxqal7FeuAb5euh2XyIBDj+TH5juVKi1CznDDrJtcUKcwn+1u?=
 =?us-ascii?Q?BiRhiZrpJVOBEh2zCdhwzEB6sIOYGNZqS/KIJgItDeqlUJ7UD421pLXTOQC7?=
 =?us-ascii?Q?8st6d1vZ7EsRNBljqVYxhbJ03zFfQLmuJHWVE+gA6xCShxRCF45wZAGEg1Zu?=
 =?us-ascii?Q?C3WXLOGuaHihqr1cp0/NpiXMpUjeCzpbn4cHg5vs8fU8gCEa9PU7i1Nuuw+S?=
 =?us-ascii?Q?/ZVTUyyPCnhjrRsZwjqWf5p4KB32l1+G1bAKDw8ftXzfZxCOEyUUIDDDKbvv?=
 =?us-ascii?Q?mHvheHIeqHAi2ZbCTJaVtKUMLnyTo/lHwqq0aA6qzKcWN+P5mjy7c/TqSH+8?=
 =?us-ascii?Q?+bdE2m7xE9Gs7LMLgprLm6svX8Dn83Qx/tqQXo3cWmuYnfewdanap72M5Y+P?=
 =?us-ascii?Q?BoPjL3mQpDDGquI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cUUAO4BI+E6cFlMOmaabgv34hQQ14p+FuomfffAqgcbZdqlQ/UlWBJ59h6GT?=
 =?us-ascii?Q?g8LHqMXpeiVig806yLbq6+9TaInyW1z/JGr4lvbSwqjkHqDxMGuJNOdlaIe6?=
 =?us-ascii?Q?jthf2v/yPeYstdkpGnruvkmaWCp2DvbyzDSbngeykiKvXbJzByzfeqADLmQA?=
 =?us-ascii?Q?NmW4w6cEPjB+JbGHH9xUqFkjQEa7Ijjyt9srVBByEL64o6zIGNBsIyHkTg0l?=
 =?us-ascii?Q?nyljaH0XOp0TLWHe446lQWM0TIQPjHkKo8hTwXbcEKuldfOXT2umZ21megfZ?=
 =?us-ascii?Q?Af8Y+ottZAOmi/ExVzIRLOEp/5fKGjuzIo2SqIpZaO1NZHmAugABSmyupfZB?=
 =?us-ascii?Q?k6UYtipuY/N/LOgzDp7aEeqwSYD/KZ+B58E2aOebo6H2xe3vkTM0EjLioXjA?=
 =?us-ascii?Q?Elqzp5amK8KcrU/x2jsz9hEsgIvA8ZBDTUeXIvvyO4VN4IyNNYsQ0ppwUqv+?=
 =?us-ascii?Q?EgGT+vq/PrMZttiGPo07hOyEtmOIBdVN7t34KULZ3heJ2NH2WFZwSvU6XkPx?=
 =?us-ascii?Q?QVEKohEMeI/myZz3JjYW6YHNUqonEylGfxn2ptMDe7NtGZE3qUU4OU6Vb6u9?=
 =?us-ascii?Q?g4uKqOhgkxxEabC5405uCMv1/D2G+QNSSoFpCv9TEOvRsyuzrkxEkYZLlduA?=
 =?us-ascii?Q?maCbhhPpi82d8+Li5P0j1f3lQXnraKxbX/tl5AnRCK6Nlw2txOfHAjKUJhhI?=
 =?us-ascii?Q?6RRn6DG9hqXCLnBKtasKRwWHzOfDV6JLIg36HnGWQf/L9hktTV69cGlUmU6p?=
 =?us-ascii?Q?zoO52MWnsjoCuI1tx/iH5gH5zhnjtFO0MYXne8HEz0aVozCzJXbYnV0atZyU?=
 =?us-ascii?Q?4FamWAIHTdfUY1DMXn/5f6JgJefCfNmTMNfPdprdiUfr572bhBcDNOh4E1nd?=
 =?us-ascii?Q?Sgo3N6oHW3Ha7gZG6L2lSJJUboqnHWvoJu9pgE1tCMaEbQZ4lVstPHORENU6?=
 =?us-ascii?Q?H+szqkp7syo4Nj/e4KupX/+Fjcq37MnX1GXXQyG2RNMl1YYlPfHH9sXPE6D/?=
 =?us-ascii?Q?ddg3y8yWqb3PxxEijB2+AfY+cJs1snKCcRdR8qx6E1bheX3FM3f8DFgh/YQk?=
 =?us-ascii?Q?jVBJ33XZwQsEq+sEo1UCUroA4j5PyVpxLHkQOUZ8dOmf0WpobF+89Rv0Mg/S?=
 =?us-ascii?Q?M2zZYTNoaV3DgVYqI3Dqik+U880aCdftbNSwu6ruT3TRvuPytnfE4iRL0ivB?=
 =?us-ascii?Q?GShJjXy6mHtNpugmTGzKWg8Ibv2dx+pAIYqhK3YoI60x0qUboCq+x9n4xItO?=
 =?us-ascii?Q?4ZuWs+j1xLTvIxR8+EXTpR+6LkUSNMeIr0nEv6NE4Gn8QYYa2EwGmfAI5F6T?=
 =?us-ascii?Q?STZZ7wYfKccVb0eZN4enPZ0qZT4nfdo+CZbZJAb0nhgOZBRbPtHlFwx00/3R?=
 =?us-ascii?Q?T+sHNvJ5RMZAya0AkXh8WJ2h1qIId7lGZyv5WlV5QFskiKEWjqtkgdaCBsV6?=
 =?us-ascii?Q?DIL9ATRc0xViIRctok3Fkfvp7pgjaesv1Cy2+TmO5IacxTSzOMg3vSrVvDpd?=
 =?us-ascii?Q?QHGPhgv8BOv0ci9CxT/PyhV2HS844/WMPuOdTb/oveDVXJllVndnD7VTPw6P?=
 =?us-ascii?Q?qmt/D740Tj5fqJvPcy4dAY/faDk9GWITeT3I4sMu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 133d9303-ab7d-4879-ee9c-08dd9de9cf7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 13:16:09.0131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICSxGZQA0lb7qj6kdA064tEeuHSLTqKpZb97om+8Cu8e9+SgvZ9AvLGpOblzKRztZtPAj6UvB5HJZq9pT9a/Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7788
X-OriginatorOrg: intel.com

> From: Rex Nie <rex.nie@jaguarmicro.com>
> Sent: Wednesday, May 28, 2025 1:04 PM
> To: linux-edac@vger.kernel.org; ak@linux.intel.com; Luck, Tony
> <tony.luck@intel.com>
> Cc: angus.chen@jaguarmicro.com; hunter.he@jaguarmicro.com; Rex Nie
> <rex.nie@jaguarmicro.com>
> Subject: [PATCH v2: mce-test] random_offline: Fix 'syntax error' test fai=
lure on
> AArch64
>=20
> There is no /sys/firmware/memmap/ for non-x86/x64 platform, so E will be
> empty. It will report bellow 'syntax error'. This patch will try to get e=
nd of
> memory from /proc/iomem if E is empty.
>=20
> Running random_offline (random soft offline test for 60 seconds)
> ./random_offline: line 61: /sys/firmware/memmap/*/type: No such file or
> directory soft offlining pages upto Using random seed 1748344561
> (standard_in) 1: syntax error
> (standard_in) 1: syntax error
> ...
> (standard_in) 1: syntax error
> (standard_in) 1: syntax error
> time over
> soft-poison: success 0 failed 19856 of total 19856
> unpoison-failed: success 0 failed 0 of total 0
> poisoned before: HardwareCorrupted:     4 kB
> poisoned after: HardwareCorrupted:     4 kB
> PASS: ./random_offline -t 60
>=20
> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>

LGTM. Thanks.

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

