Return-Path: <linux-edac+bounces-4360-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698F1B04D86
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 03:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489104E0BAB
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 01:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65298288C15;
	Tue, 15 Jul 2025 01:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXmncij9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07821553A3;
	Tue, 15 Jul 2025 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752543437; cv=fail; b=dVrRIrcj2K9ceFTNohpxAyJqwwZbLSHM5BOutGyyWeBLo+jBJDgEr1s2eDtjLJ1h2uG8OS0otR/Tizy4XKEb8LrpTL4r5xQ4Zz5oAb+BqPtuUH/BHWCAx3nkiD7xlBcKUM5yHOs6tp2aptdeEfEc8DG5cNMhe2nGZ0thnnOo+/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752543437; c=relaxed/simple;
	bh=Blr47HY/fJW8jf2F7FmY2aoBh1VfMkkPPYcSZ5fxPHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nw9bl4oCyfkhW3UR8oOg7GGQBXs/mieq6fgGEZPkEGPMXBIxBih3AhYmf/mxmNpmLSK71aLG5+oJwLQ15qYzDsOAkGqAdtXIIHkx6/Iu4dmMNvxxpam2OiuaKpKlV49iXdArzBf/HC0fuwwqce5C1dnz9vMww8Yn291CNg68WSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXmncij9; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752543435; x=1784079435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Blr47HY/fJW8jf2F7FmY2aoBh1VfMkkPPYcSZ5fxPHw=;
  b=IXmncij9mdBDmCq5myQI8SroXZhXO/UlaJAsPcVs4zFSelB+xNZfiqww
   aaWHaPVQ84rCzQKbLjKOh73N7TOL7fzBunr8Ev5xD26XZ/CVN98/n4IOc
   QgobP+g504dTAhJCuRBwKG7MQnf5GW7SCRmtX5r8wfIIjXsVxXasFq9yl
   3vE/l1dyMQ9nc5ioWoGjq3UwesRPK5lT6+GJ2ZQtEYelxQWf5fCrILkrL
   zSjBitJbKTdpRJSMT/rxzKUHIvI0bvNM+mGz5ZWToOJHhE0fQLMqzhaVb
   OoUAFRnJInKHWDpMDedUPe0UKvIEYxjhf1m2HocfiaZ9L9/PsTCp51cXQ
   g==;
X-CSE-ConnectionGUID: 8/XGZcUiRPy2WnI9GIdzAQ==
X-CSE-MsgGUID: 503LofTTTbmnfNjj7FgMZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54686489"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="54686489"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 18:37:13 -0700
X-CSE-ConnectionGUID: DVxgx8ZnRo6s5JnUGqf4mg==
X-CSE-MsgGUID: Wa1xy3N9Qs+ltGtb0af/dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="188075035"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 18:37:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 18:37:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 14 Jul 2025 18:37:12 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.48)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 18:37:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCzPcPh4HvkZFNOzxqCbopVORuR+zHwXaBeHw7/Rd3IVPS/F6+nbFF6boBGk2B6sRmgPz66FOFLBjLazhE6m/PYhr11xe8K3y44KNjmsexxlVQBjwoszKmWl0p8p5BooD9nC4tKcZfwTMtcVponfsbdQM30uNiyrLTNlNx2Y2qA5AsmwjldUTNfxwEHDvrmxdw8eByG87xGwM8irVGXF3Rq9iunRftjYarYjLbcsncM8lLO/GatwMwqPzKybX4C6uazOTuDrAU5dJ+5hyUNZRGR4UEV9f5D2PidrGUFZp5VOx6/DKZevw6+sGdLRA7FDLD1LOr/7I8dg7FJ893vVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSMiNYaFG71pGN58x37P6VKLT0c7WbgaLiwPjHiD1ZQ=;
 b=UooRwpGkvZCi27GBnSSDKSas7Pzgk8HO7GbYxKwRHlpR1Vz/NhR+IFlObV8RCMa5BxEWR+XFn+K0JjX9vkzxx7EgI2P2RZJyclwVIvYRGq3QA5F31gCXUVW/j8ancFC+XuV63O/cqKm5F61WOkIKaiU4tmexw9GeYGkYTj5s9sP0XLHOK31si8N3lOae0Xjz3mkvswI4u5oj5X0+O5nwAxTPMDUjS8g2kv+1Mt+yaWwARWfU5GQhEiyHwBUp/lbxDNLGR9vUngKjqbZhElE5Mk/h/f4EvkUmILTyVYAq2JfrJHLJqvJgzi4GQJ19bu8zrXoZLnF4UbvKmzTenGQIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by LV8PR11MB8462.namprd11.prod.outlook.com (2603:10b6:408:1e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 01:37:09 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8880.027; Tue, 15 Jul 2025
 01:37:09 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Wang Haoran <haoranwangsec@gmail.com>, "Luck, Tony" <tony.luck@intel.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "james.morse@arm.com" <james.morse@arm.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "rric@kernel.org" <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] edac: Use scnprintf() for safer buffer handling
Thread-Topic: [PATCH] edac: Use scnprintf() for safer buffer handling
Thread-Index: AQHb9MgT+cQpPIVyDkqinYzs4OU277QyYTdQ
Date: Tue, 15 Jul 2025 01:37:08 +0000
Message-ID: <CY8PR11MB7134D3D5446423DD485F0A438957A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250714140130.1092079-1-haoranwangsec@gmail.com>
In-Reply-To: <20250714140130.1092079-1-haoranwangsec@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|LV8PR11MB8462:EE_
x-ms-office365-filtering-correlation-id: 1873831a-96c5-4139-8ecf-08ddc3401d12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?puUB+ptrf2VsJtR8XXrdYPQz5qx1tPnJQoz83B5QcHItDxg9rHsFbuXcHx?=
 =?iso-8859-1?Q?iZbC1/TehIOc4EPa3PxjTGfMCOQbwTMU0+etndXrWnkS/tu4yK/qMpPWc0?=
 =?iso-8859-1?Q?5wazvaJlCsqEcQVY7QUxCL1QHLGfklLYKJN7znccaAq0OzhGeqzVPUqxTz?=
 =?iso-8859-1?Q?N2f1bNrHFwYRTzX6GM9W2qagxbWS1WJwz97ebPzFX7irZdE69g3C+1c+bK?=
 =?iso-8859-1?Q?1q/JPShIiWQjpO9TgLm4O4i9zUY0dsE/xYTHJnTcm4dwonML2bnaPdaND7?=
 =?iso-8859-1?Q?3OozMgT05J4oQLdTABC3ha3lJpc4CLOdlcS8WPd70NKut3CBHG7noOeAp3?=
 =?iso-8859-1?Q?5iYjnkhRcUHu5MfSZQkAiqPYGbMW7+fhlbvupMvfw8Xx6powaibiNz/lJp?=
 =?iso-8859-1?Q?gEDqX8LgoryxmPVdSBvY1w3kjclEUW5yWxaXErCCAr6BgpCL9DE0FHqsOA?=
 =?iso-8859-1?Q?YDBnK2J/yx4NDWc0WIj0OAaiXjZNZKFlbbzKi6LL7U22V0Gp99OkoA95BP?=
 =?iso-8859-1?Q?5EZDvDg4HO3v3IhXroHsAjzF+mfp7V9jtup9p5X1Q15zbsaIQmi2bZuJj2?=
 =?iso-8859-1?Q?voBrs1dkx9P2jx9TWv2QL/ZTOe6fC3CL9mj3LZsV+ZkMk6eUsDxcNfovi8?=
 =?iso-8859-1?Q?U1dMR0r0Mjuay7xz8iigWQo75bL2WPY6016oE/8Pzd9E8BybUBlNAArau5?=
 =?iso-8859-1?Q?UNHPltiwXCLsqWSj7u8RhKvvZM9KNy+c+vDCeo9Pmy9Ek/7NTo0QvRggHL?=
 =?iso-8859-1?Q?uXgYgljxWV/rggWYBNBHBfTwCcBYNREmdoO5ZdAJq17VyAuoPg6gJOH45X?=
 =?iso-8859-1?Q?1XOMdzYXz+Wp5T6pXfi4J6J0yFostMmzifTCUhwnoB+NW0OZEpKss4N7+g?=
 =?iso-8859-1?Q?ztV6ABuNYRrtdSJLD+x1mjlninmAjBR5tae02jXTdUg17gipGRNPQjoC7e?=
 =?iso-8859-1?Q?YZpgIOFz9w6PgafkHYXFIPbtuKsmcVZwfVFdA3VuI/ZKc6oagE7lO8vNnu?=
 =?iso-8859-1?Q?mIwJ1djzEfC68GdiAdqipStragP6G6JiXOr/pv/TexuyLIobE04wPoCdDu?=
 =?iso-8859-1?Q?lMABeDm5uyMdiiYMAfQWY4NFmlJz9q7fPhLlQbbKdGPLk4dabZlCRgJkLx?=
 =?iso-8859-1?Q?e0frP32MzvAgRGILbBi2QS+iNz81lRiFTQqsBlgKNK2CbM6V3vAFrSXTVi?=
 =?iso-8859-1?Q?ChO4u2Z004Hv99kTd2AykShcuYzgKDu+gQSI2ttAGLid7rFeAKe8CzebRn?=
 =?iso-8859-1?Q?ei72GhniClxFOiPoXI7flReozHRZxd7ierbg8DFgp7DGOcS5HVO8qD0ybz?=
 =?iso-8859-1?Q?xfzmsgSGSW1pkBc+69Rs1oU7gJJXMY/K79mvnyuoIZWlE6MNa+EndPmH1w?=
 =?iso-8859-1?Q?CumjuE0gFy3LBRb8zlJHMo2aboCllc2CfcIC+1Ykz9ivIJregzNHq+SEqY?=
 =?iso-8859-1?Q?H3uVci3ivEJeJQGE/Tp3FmBE7fQhqOPFs0l/RushsqAe6fSj/D+GEVNd1h?=
 =?iso-8859-1?Q?r4C4PCodPUnBH/OfaeZW3yCmA/NuQji6FceMpp/OvunA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GSLErBAB/GMwnet5lfyZ/AchvAVY1KH2hdSn/IWoUQkiEkYLirheTCCeim?=
 =?iso-8859-1?Q?sAiuHZW6gMxRbZm/B/3+O7+AS0R7PbIWjMzhSjVo/68kLeasMoK72mIzwA?=
 =?iso-8859-1?Q?YYUXQYRKU4rU80BtbmD3aPDgd+BYcmWLYvXPf4dxS4NV8h/WYr+GWdtGb/?=
 =?iso-8859-1?Q?Wj6shgvYNWjmHPlhZqCcrvubv3F7nHnw0lduaGzxkE0IGBu7gfK2BcA7KC?=
 =?iso-8859-1?Q?9tBZ17ubWFVqvn7oMQDnnPa5MM9mFIU24T+YYBeivDy+gKUhT12A/bRZ29?=
 =?iso-8859-1?Q?b+5A8e+59evvjh8fq0Za6cbd5EzGQeIFN5SNYocqq8cEbQA0w/wFnYrrF9?=
 =?iso-8859-1?Q?XjDFmdu99ZaaAuTaGIrNFg8AbdBfdXQ5Esj5f48m2Zcn57w0cw5JYrQvQi?=
 =?iso-8859-1?Q?524Jw+LhAkd2zmGDqqyO2IeEjAzP7CiN14SwivzgAGxRTcsiXuLW28aUga?=
 =?iso-8859-1?Q?OQDbxIzY1iXa8NsWANEtwjcYE58RVmRXL/LtGCZ75zHD3jq4phiQBJfyWT?=
 =?iso-8859-1?Q?TankqL77x0TFXzKnhKMSGV+76hsuT3QCc4ocX+exfTytd47xMGYVyRuZR+?=
 =?iso-8859-1?Q?UYFctt2CWCwXQMBAr98fRgnPhWOB0vsiqFCdSdLw7SmkkN3gaj8ViCerK2?=
 =?iso-8859-1?Q?EsRn+sx9C69ZKRrX4kR+vHM2dNCtg1GVrXa9oYjkRUMaKAsuUWVRCFS3WO?=
 =?iso-8859-1?Q?TFXjeSz/bbLgFbVU0p41nxXKJsdcbKKpRAnyo3yMf6e2TZW9n+93J2Us9G?=
 =?iso-8859-1?Q?Dfn8rQwq2SKvUiHoU+B3ojbG/FpKex775ygQnJvfQCElv16KDNLSrS2EYm?=
 =?iso-8859-1?Q?WPqQxWxT8L3WqCevaabsOWFZk3ndFiBOXNJceH1tnkZJHUTyCVZQ30bbcM?=
 =?iso-8859-1?Q?oFsbFDH9jwuE2GanazD45Ni2zycXImkJ0LMtmi2JXcGxNpLOdG+WOhOkZo?=
 =?iso-8859-1?Q?6vORMQRsfKFVXhK/RgIYOonBoSoVKIjYzE9LqZLUNr33HoFpdsWSqeUze3?=
 =?iso-8859-1?Q?QGBuI81+/W2H+w1fHVeotaY5r2iC2KTjegM/Fc1/LNuscqYGcHI8+55WOS?=
 =?iso-8859-1?Q?iJIjAahfKunNqFeyt6IdYWZSKRw+41A7njwX3TJ3wt4t9tCAj4O6jIrYx5?=
 =?iso-8859-1?Q?hpVxFUhgqLmn2VfhGJ8E7EPPnFEDdjfxUAYOj3/RyWT6oGW3a14hPsaefj?=
 =?iso-8859-1?Q?2W1CfBv+kFRjQ6Str1II5iuJYUwb5FYJ0C6Y+VEGJ6x+RDuQPmDq8cPw/6?=
 =?iso-8859-1?Q?XCDYKVgMRfKzbx45/U/U0wo9BfolhC+C+eQEoPaKdTSShMTbhB4PnzNwQS?=
 =?iso-8859-1?Q?RLgHQs60AGjH1dOLjh/1MXbGlmS5Be/QOCbgp77AeSnE89VtmhQE3FSpw7?=
 =?iso-8859-1?Q?V3mdlkmtdKx9dRz+PP8qJcky3+cRC78BLPVZwez+lOQ0TZJqgvnTvcEY3U?=
 =?iso-8859-1?Q?7XqizxWbf8NBBqlC9NRzZWSeqFXh9QQf84zNRLwdTfL0LPhv7vqm1JdZGH?=
 =?iso-8859-1?Q?ps8w20pTye5iUVZSaommeQOgUyT0SsuiwOMGqJSFcD36CGvBTZsZncRnbf?=
 =?iso-8859-1?Q?qDccxNEdqL8Jo2GCBlgqeqvkwQp+0vpI5cTs6fNDTFfbDPVcXDYD59jjKN?=
 =?iso-8859-1?Q?ov/zF6vU5tMT5YkOd5iRElxHEWPCWz4hOF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1873831a-96c5-4139-8ecf-08ddc3401d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 01:37:08.8982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RgJIfO5OnI4f09uiv0bZTYGExjs+SYJTBRXLgKZ4RviqzN/f6Pxs7ZxKazWRqu065fMyq3kE7hDVKVeY5/e3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8462
X-OriginatorOrg: intel.com

Hi Haoran,

Thanks for the patch.=20

> From: Wang Haoran <haoranwangsec@gmail.com>
> Sent: Monday, July 14, 2025 10:02 PM
> To: Luck, Tony <tony.luck@intel.com>; bp@alien8.de
> Cc: james.morse@arm.com; mchehab@kernel.org; rric@kernel.org; linux-
> edac@vger.kernel.org; linux-kernel@vger.kernel.org; Wang Haoran
> <haoranwangsec@gmail.com>
> Subject: [PATCH] edac: Use scnprintf() for safer buffer handling

Please specify the subject with the prefix 'EDAC/{skx_common,i10nm}',=20
to match the=A0previous commit style, as follows:

      EDAC/{skx_common,i10nm}: Use scnprintf() for safer buffer handling

>=20
> snprintf() is fragile when its return value will be used to append additi=
onal
> data to a buffer. Use scnprintf() instead.
>=20

This lengthy commit message can be split into two lines for easy parsing.=20
Please do so.
[ The tool scripts/checkpatch.pl suggests a max of 75 characters per line. =
 ]

> Signed-off-by: Wang Haoran (Vul337) <haoranwangsec@gmail.com>

I tested this patch on an Intel Granite Rapids server with error injections=
,=20
and the i10nm_edac functioned well w/o any regression.

    Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Please address Tony's comments about "Vul337" inside your SoB.=20
Other than that:

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

