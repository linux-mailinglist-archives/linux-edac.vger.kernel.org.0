Return-Path: <linux-edac+bounces-4351-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A048CB03429
	for <lists+linux-edac@lfdr.de>; Mon, 14 Jul 2025 03:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8C63A8035
	for <lists+linux-edac@lfdr.de>; Mon, 14 Jul 2025 01:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12AE1891A9;
	Mon, 14 Jul 2025 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cy/Wer9A"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A263C17;
	Mon, 14 Jul 2025 01:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752456384; cv=fail; b=M9MN78C+cr7HxavCgCHhzLy6uXrjgmgsUCFYPXbSll5serdWWvV5WA0ShqtFYhuUwMkQrfFf2zGRquFSkzJ/I4gz9uDZIfkkg4lsEypBcrzVRZ57DNBMKnjpOFWbGE2sGizOZFqPeuO/LjuphQ1Ftn9i9f90xUnJCDUI32ykAZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752456384; c=relaxed/simple;
	bh=4mhkPlLULVTcIMyvdFbty9mEAFn4aQsuWJqb8in9FAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=soNFoCOR+H9qMxgNB2OEKZKxXOJVBiWOPhcL5r3gmmn4fi38/bIEDM8bmMJ/igGLg3hau71OLyjhtitdlXSDNkUZqRvifTadhAgB1lZx2QoRPBoLKT4jt6Y3rE0repyXtTZngwzSUIDPhogwGVi+mDNKPfC6erpzxCX8YW0CnYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cy/Wer9A; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752456383; x=1783992383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4mhkPlLULVTcIMyvdFbty9mEAFn4aQsuWJqb8in9FAE=;
  b=cy/Wer9ArktHIaaxDbhD/AC6yf5Po7aoueZ25LAF5ZBBZi9nq0IrNs8F
   P2HXA5bNGZEOfHUZ9lFdXTfVP+Qtm6qAmpx8LOKp+czkCCq06q79OGpLQ
   Iqaz0QReA3VRGlo80meHvTeTghEcSxjUZWMjIhxY5eHKw0DICfmB6HyoW
   k/LZ7+qbuIXaYUhmWTgX0VK4OQ3fptuGJLGqtRcQMFWjnTmikZjsruHgD
   FvTPCb2cNX36XEdas4lMXtFHC9GmSu/kvY0JUUn1vstw1q+bAVxPLQcbt
   M4ream0FpmbpxqHeRl8jkU74GrYoQAVy8dqseBQuS0kBw5Z9i5QxCz0Hp
   Q==;
X-CSE-ConnectionGUID: nDpuBU2zQUCVD2j5iOTmMA==
X-CSE-MsgGUID: S73MYMjiSsWEirJe9J/4kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54773196"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="54773196"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 18:26:22 -0700
X-CSE-ConnectionGUID: fPxsBF91QnC4dI4yWUZHwg==
X-CSE-MsgGUID: 4CjNcZ6YRiOI+OIEABl20w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="156233970"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 18:26:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 13 Jul 2025 18:26:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 13 Jul 2025 18:26:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 13 Jul 2025 18:26:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6MjC/YoXpr9acXRPeTbZ222IGWAuuWPCbFU6hR+WJpy6QpwmP3dCdAPM/o/mHAul60Zt0wCC2H55TM02X6ATPLFIYCcxkAj/SW+GJptCio4HdTL7WmfRtHlvAzn3nsAnmgro+2NVH+voW4/DXNCpGxLot/ygGPX3RPbObYFA0g2Q+6Jr8dvUNHssIgC915b8D18OebEEKWo959i+70upVloP+NIiHAM7JZisE1RUonAMPmEfIGxd5KFIjLjSS9eFrh8MIYKgjeWtQSNtBg7wTK9o+EW0OPy0e7RcvY94zPFBGczKUgG/EhVf/H8PQK2mB2EGoY1ZZJkwlhU7zFcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCTsSYWuG6zllL+yHGWYZjRL4uf1xK4YZs4wvf1gkYc=;
 b=VBYbelEGNMBrexh2GzRZie0KtLTiig5V4OLrTW348OPy8W3plgyBpVTZJ9J/WmR6R7kuZhChUi1YxTj44kmyHpeQuWa3zuZLDUS0EbhNVpxXoustZa3X3cYStfJ5SQxMQ4w0BdP9GYWVTbZeNEX9PAI5MigVXe80V+7uPE71ZyrPuKvLO2PjPvneFd1xYMPPOmlbXA6Sja5whxSJh2d9kbJiR02hNMEJpU46bXt4gVwSIHDnFSeo7GuxVpUghNNrpjajRblbw4voTzS0GC+GR1xeBw104QpHKYDCOYUmjojuw+g7Y9CcZpr4E+Kotk3I+LUzgi1BTKYwdf5l46J8qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA2PR11MB5147.namprd11.prod.outlook.com (2603:10b6:806:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 01:25:31 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8880.027; Mon, 14 Jul 2025
 01:25:31 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Wang Haoran <haoranwangsec@gmail.com>, "Luck, Tony" <tony.luck@intel.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "james.morse@arm.com" <james.morse@arm.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "rric@kernel.org" <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] edac: Use scnprintf() for safer buffer handling
Thread-Topic: [PATCH] edac: Use scnprintf() for safer buffer handling
Thread-Index: AQHb86IE9visgs8oWEa0B8T5NtDEBrQw0w7Q
Date: Mon, 14 Jul 2025 01:25:31 +0000
Message-ID: <CY8PR11MB7134751986E9092C9B853CF98954A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250713025744.1091545-1-haoranwangsec@gmail.com>
In-Reply-To: <20250713025744.1091545-1-haoranwangsec@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA2PR11MB5147:EE_
x-ms-office365-filtering-correlation-id: 922a7878-0806-448a-49ff-08ddc27552e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?uiH9b71T2sfWD7Yz8YFUxPzU/neqFZBYaDeybZs8EsZYdcqwoRW761i2EKQv?=
 =?us-ascii?Q?ylRloQsJTMhndN7QW0ShP8gqaLKDr81cp2aKrrHREd7Eynwob0YHT4hPwpDp?=
 =?us-ascii?Q?0c6tXK+6iUsbhEkirixRtZ4G/j5JqeDrdwBMPkCuayfDx59vV+a13M/xfTDx?=
 =?us-ascii?Q?VLdiRYLrDXhryKCpF901WzLmWBQP38Y3jVVxOEWf0KMEnTwL+ceht75kCBuV?=
 =?us-ascii?Q?KZmtz/PUIgXGmWLGLgnBtOSrIVX0B5Ocfaz7hBtkjFsC2rmcZq/LmKPQJiUm?=
 =?us-ascii?Q?x3Hx8XG6VnmxR8XuhjqJSDvYXjQrm6Y4V4OcshX2gmf0K6aKl6DhUujeGVP/?=
 =?us-ascii?Q?X1Ge4/fKVmfEAt+mZk81iAR8Kr6E8PfAnDnbwQl4ufPXOzjFBkYeAiA3uW41?=
 =?us-ascii?Q?JgxZLsm6HSAO+uRGS8V3RRzLEizH1NVaI1pRu/u/uUgdqHfXi6FBnRT6VF8I?=
 =?us-ascii?Q?fNsiz9XqhzTnor35izIVvdHp0LAGopHafCoZ3JQmbO4u2ainuQeYXPJaDGvr?=
 =?us-ascii?Q?EVXWTS0/1Ce0l4NoriarYS+FmvV2bZdIKekayN8pb98zO6djOb0M5LaQOrVa?=
 =?us-ascii?Q?GjkLwf7ApHv4+X3nL7AWzIBAB32Q5rbJrHG2ThD7BYmKDwWYEViZOqFbgV/6?=
 =?us-ascii?Q?E7o6orHlkmPEi6Fx7rQ06/VTCR7R64wyNS1Go9UJjZ96zrsWmgbz5viH154D?=
 =?us-ascii?Q?sgRbD0add+juqJBirAq0E/zBy6YA8DVJ6djx7Z0W8+6PbX76xyx3Ek1kZMLk?=
 =?us-ascii?Q?vbfRWbAHWPyRIpXA5O6ecUhhL8pPJ84N908+7ZQKHdhVlPGJ7+Mq9DcP02Sz?=
 =?us-ascii?Q?jnKNOOec5CoxBCGysBVQBLpIxFDyNRws5+53q4W3xrD+Ame/+5QRTiUM7GmX?=
 =?us-ascii?Q?Qs2it1CYrextGIVMFhewgULFrj8Mm+AEpZAlcvd1yIuRglRVnJ31mDwK8sMR?=
 =?us-ascii?Q?xuCMMA9Par1XsdiiP61I3Iafzh3Os2JPjZeAdabdNuZV7E1Xmq2twbmlAEe6?=
 =?us-ascii?Q?NNaa8+0PqFh5yROIMVYB+/MXIhumHRbq08VmvNp6KHhNdI0qs98O5Sx0HTDX?=
 =?us-ascii?Q?I+DbYtKUgU+OmaWpQ7NLginQiJ1OF4Jqvpt1SfB+x9bWrCEIuTHyGtxgMS7k?=
 =?us-ascii?Q?Qp0yL62tsfZ/t0VjWFv5GjPpdrrYklPa6/JrbtdDj6Af9pVPpKvYYV39HTd0?=
 =?us-ascii?Q?QsByDvIWdogV7l+WKNn6pPprW+2Wm1mpJr1kZ/uWUgZSCzK6KEzEk9KYqbp/?=
 =?us-ascii?Q?MGkR3ZuMg+HCyZl0kn9FAUVWL6RcRcI4zv43eFJqJSU9excqM8hISXJtAgwV?=
 =?us-ascii?Q?2eUKjd3UT3KSMnbDNG1Q46hani1L0Y1oSMTSpXhtMh/750pLmvBFGStZrHaH?=
 =?us-ascii?Q?GwQsCva3otUyTMA91Dm9V8teeGQCJw9+10/aQhhSKW7VVUqO/j18ZoYArHpm?=
 =?us-ascii?Q?gfNO/PjtWBmePw9PQJMRvbwMwftdFcms7uoUju/SlPIa8YtWiX0FlA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?16McPYNB94tWf2aGg573otyiS021IBP22IfIJK1ZVdaO4zCtk09pGNGGP6/P?=
 =?us-ascii?Q?SdUBShacgD/L/RKF8UYCceZFoklzOItncpWO03u890DRGEmkbAWP0NrIMWtY?=
 =?us-ascii?Q?ThwOqTqXmj1Mz12boQ3tTYXemmERKnLpWFNm6BWdmg3zyNrXAeCE78QW1Wxd?=
 =?us-ascii?Q?Hwy4hdidknjFE9umPJ5ZFnLMydl6XItjO5w3LuaTPqG3pqbJZZ7ox0kNxZze?=
 =?us-ascii?Q?6EbNOe9qrIXOm/e8+6oOldJPzEAmjMBfbU0b5VyUiWleHYsoWqAbAMF+Bwlk?=
 =?us-ascii?Q?4+CnQQMbOhcuD3Ius5mUmY1dTszZMYCTlMe8elBPOHLEwiee7D3v9b4pG+wS?=
 =?us-ascii?Q?jKoKCjzeBv3IPzY1/I3AiBGZWyRk99CV5Fe9AW5GAlMFE8Fqa4bbvrTu1NUe?=
 =?us-ascii?Q?+6++l9UgJECojQIgNmvX7NWdfVYsi46zW7ukbiHCHMi1UtQx0HGV2Efah1sX?=
 =?us-ascii?Q?60nPkM5JKRL0OI6XUXBBO1XHQCnPWlOUOZZqxt1OUQWN8BE8HxJDUSnY99UL?=
 =?us-ascii?Q?8KF+xLQdhSrd/Fc0NSJpDN6NE096RhI3ku03TsGodaxyVotGJF4BFYFIMau8?=
 =?us-ascii?Q?Drm1NHr9y0/W7dO0FOGZISmoKXVNKSddQGMSCU/5peXDnfhRnp5zbLi/RwEa?=
 =?us-ascii?Q?TaZ7+eRW185iK+aUU3uRoptcoPPY07cgf/Fw70cvzg7aQPSA9oscmztud9FJ?=
 =?us-ascii?Q?Xe0Kqz/5mbKUJODpM1D6SzmUU6io9aYDyRKVTAlQvhteIRVGn2iNscFsmUxT?=
 =?us-ascii?Q?H78GLPVdrUQsIpW+PZD222+/otpvD4aBudzP+CAh20xi6ZZY+zQn7vX67Tc3?=
 =?us-ascii?Q?COadaNwy9+atiVyJfCRWyHD9GRJJS4CbKmi5b0fVsompEkKQME7wb3lxhbef?=
 =?us-ascii?Q?fg/XlXGvla0U9VUnJlJWeT3YwB8k6+mK17m45HstX8bOrW8yak1gOH+FoVnN?=
 =?us-ascii?Q?v6cy3b4fZzzPA2AxzEthH4WJqeXV7zB6rWDUn2pcXEnt+5Q3VvfUEpO93DAl?=
 =?us-ascii?Q?Sk/NWDeIqmyUTkxh4DMMEiwrM/gPg+JFClxzUSB4W5LPvZ8sevoKzsEV70d9?=
 =?us-ascii?Q?yv15ogkB6Gy3+qxUO2EJbRSPuWfMf6YNl6gb1sxRq3VCVXSqyXIW+W2tAVGl?=
 =?us-ascii?Q?RIGneU3/Edf74jcOF8lHwPno+isArv2dgmX6hr0dp+XQWNykhmdqaONfAGcy?=
 =?us-ascii?Q?OFhLUs/TnH0wh0KQDYLmI9lT59+KvJylB3hHLmMNAYnBW9DmGT07WRNUQwCI?=
 =?us-ascii?Q?n5P5CJqlfD7i10Sv93b4uDZ3XakJy78rA2wGYSAsxP4UYudT9jfNfzmEXuF0?=
 =?us-ascii?Q?+TPVMjlu2mpWeLv+GpUp47q4KUUVnsjxMloQzXTqQ4lkKLKrBP7lj9fDBLws?=
 =?us-ascii?Q?eQvxrHMqQPRn9z5oCnfVHvmBXctJGuJvu8EttDV3jwsD2HL4gKJ9raagpHHk?=
 =?us-ascii?Q?oYcECXuBJup9BhN1JeyvHThdui8aW61ks/KaqrvCWsgk0ojXFAO1qK9J+t+x?=
 =?us-ascii?Q?HyofOc77B1qx5keRmRaXNxBzqriz8CeolnYj0NB334F28dd+3l7kWvFiHTaJ?=
 =?us-ascii?Q?xA2nDGPpdhbflA1/lbEsQZA0izwEP2719NfMfE0A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 922a7878-0806-448a-49ff-08ddc27552e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 01:25:31.3552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovrwTY+Ij4TBXf7JCdmZ+9iIMO0HxJ7QAGYsOCkjB7V4vksYonHjyZdqC7yXOKc24twFeskgbFGZYVxDesa+dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5147
X-OriginatorOrg: intel.com

> From: Wang Haoran <haoranwangsec@gmail.com>
> Sent: Sunday, July 13, 2025 10:58 AM
> To: Luck, Tony <tony.luck@intel.com>; bp@alien8.de
> Cc: james.morse@arm.com; mchehab@kernel.org; rric@kernel.org; linux-
> edac@vger.kernel.org; linux-kernel@vger.kernel.org; Wang Haoran
> <haoranwangsec@gmail.com>
> Subject: [PATCH] edac: Use scnprintf() for safer buffer handling
>=20
> snprintf() is fragile when its return value will be used to append additi=
onal
> data to a buffer. Use scnprintf() instead.
>=20
> Signed-off-by: Wang Haoran (Vul337) <haoranwangsec@gmail.com>
> ---
>  drivers/edac/skx_common.c | 4 ++--

Please also replace all instances of snprintf() with scnprintf() in the fil=
e drivers/edac/i10nm_edac.c

Thanks
-Qiuxu=20


