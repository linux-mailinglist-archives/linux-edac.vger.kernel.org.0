Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B78400B52
	for <lists+linux-edac@lfdr.de>; Sat,  4 Sep 2021 14:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbhIDMSc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 4 Sep 2021 08:18:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:47016 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234198AbhIDMSc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 4 Sep 2021 08:18:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="241912823"
X-IronPort-AV: E=Sophos;i="5.85,268,1624345200"; 
   d="scan'208";a="241912823"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2021 05:17:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,268,1624345200"; 
   d="scan'208";a="477650964"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2021 05:17:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sat, 4 Sep 2021 05:17:29 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sat, 4 Sep 2021 05:17:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sat, 4 Sep 2021 05:17:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sat, 4 Sep 2021 05:17:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Td1nkrHZRbeg06dVEzAw+fnFmCiiQ5ANWNmP/QqPJST2YwopQ1VP7mCOhZwCsvbuKplw6ul0ERpG6LCfS0qLtIAVNiaeqCZbEP1i4oTDstcvvcbm3SXePBH0BWMnm3RuCuWxmxtbB4bZI6hhKAR5j3x1XHJ3rjDgYrnaeP1wrnUiDM8lOpXGtsmeXWyzHzBZ2WnMy14IlxuwLhy+CEDAOUWw6d8OsdB253i6Sub9kxsjT42UEaqPNHW3gz+U041cWSZuERwzt9dYYyftFqVpDjNhBMuz8LSDep1gxviQ0cTnGF/o5dHunvYLvHdohAAuMRUB5a5AMp7ZrPY9nlHstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=g/LPeORNZdOh7224pWcKDShU3BB/TsbsGx28nKqUGaQ=;
 b=KFAMGRq4G0aLPJKEAivQI49HLasiiuRsE8m0F4cRKopHxarhWyexdM0qeYSJBMAW6c+OUpW/Q8YQ+Z8fcc+LbuCYPPFMYqRkRL1Ywqtd9yTTZ8/Ee9i3SUvBTJR1QfIHCKT3vduolj/ST8g4XMCLF1SB8tJkVkyKaBZVbVaGdB98EBO/VQnq+fw7sEtiAlGhUcZTKNnptIq2JRTKXDgBdO/H7bNNs0nfnn7oeGA/CAns1Ts0h28uYQxU4Vs8GHZ2j//AwBTkx0gK0mMKL+G0kV/Zc8Foo0xCh9VoTTWHEQfgyjgWG7f9XPZ0dC+/Uwbvn4+yFnrSCXFkcucZsG9wDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/LPeORNZdOh7224pWcKDShU3BB/TsbsGx28nKqUGaQ=;
 b=SSd7IpdF8BMxdqAJBIUpb/CHABN18OL+qj4dy4lShhpYyBKOrnrAkzXTve6DMGGoifBqK8kH/2/quvLUh8HVYFbqecVng+6tXC5Kzx1b7ijM3EiEdByUE2c+zGaLENGgJxSIEwlYu8OWkNQF/cfOBB0r872bfAvsUj2VVDzX7pc=
Received: from DM8PR11MB5669.namprd11.prod.outlook.com (2603:10b6:8:36::10) by
 DM8PR11MB5669.namprd11.prod.outlook.com (2603:10b6:8:36::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19; Sat, 4 Sep 2021 12:17:27 +0000
Received: from DM8PR11MB5669.namprd11.prod.outlook.com
 ([fe80::90ea:ea18:475d:a98b]) by DM8PR11MB5669.namprd11.prod.outlook.com
 ([fe80::90ea:ea18:475d:a98b%6]) with mapi id 15.20.4478.024; Sat, 4 Sep 2021
 12:17:27 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     'Lucas Fryzek' <lucas.fryzek@coreavi.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     Tasos Sachanidis <Tasos.Sachanidis@coreavi.com>
Subject: RE: Error injection interface for igen6 driver with Intel TGL UP3
 hardware
Thread-Topic: Error injection interface for igen6 driver with Intel TGL UP3
 hardware
Thread-Index: AdegIY55w7FLAYKlRm+7S8+0PntwRABYfv7Q
Date:   Sat, 4 Sep 2021 12:17:27 +0000
Message-ID: <DM8PR11MB56695C8350F2B0F7671B1FCD89D09@DM8PR11MB5669.namprd11.prod.outlook.com>
References: <DM8PR22MB2760C71E24679B1BF6732F4A8FCF9@DM8PR22MB2760.namprd22.prod.outlook.com>
In-Reply-To: <DM8PR22MB2760C71E24679B1BF6732F4A8FCF9@DM8PR22MB2760.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: coreavi.com; dkim=none (message not signed)
 header.d=none;coreavi.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36e731e2-3c21-41a5-6f42-08d96f9df603
x-ms-traffictypediagnostic: DM8PR11MB5669:
x-microsoft-antispam-prvs: <DM8PR11MB566995E49CBA583F0731137B89D09@DM8PR11MB5669.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1IQLwbu9H34Wfp8rds42i98NinO0rubmby5/q5toyriN9ItCyAv5D2fwmQz83nDAPPFn9axlmF39JLmihpnVSDa8x6ZB/jekikDYEJNZ8oVDul0EsjA+p7ig0TwBQruhp7Ww2dIBkuZNHmYoHG7F87aIOOI4zQER1CrL6tC1ln3PutB9rviBKNOS57aSSe7vC2kNiEzPmrdVpzGx1su2vN5pgWGc8wkzrDVOjqSP4vWZ/WEL6kGpv1rhkvgKcejI0k4yOl2m3u6C7VZcqEmoqX2yt2gi0m83me9Xi6Pykt/w9Orw0q6GEZ6jwXHtQ+aXAoakIEUcJ02RRqNkdQOqRgHpZyPIVowhp8RA5nmB1Mcht2do2p7jROHI8uM4czFoCVGXwWVZImryV1RLwC+JFIxxpNUBQ2C5pL9CTgA8ZQijbImW3a952eha/qJgWRsr2rXiiOuaOzTwG+dDLbk0x9FbruH1AmrHqfidU8HZ8LhlMO3Qj1eZdQPeKCAGvFOVmc2uRDn6jBnnMWT6VHPcJLj3pEvlb34/jTCi22M7LjOLwJlp/WKbBPArOVmYLqn92NuKVpvlI2a/aOnebtgKA/8ILDUw0TYMNUGw8BYqPniywOV4At6KsOKyx2ZuzVuE/jgJqELfHHLMncdjpwwpdMmLnSp7iATgaxUnBXZoE1kXfhqKY3gX5h49UCSRKParzXtAkWS5wAUTYgLrjpVx0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5669.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(186003)(478600001)(38100700002)(71200400001)(55016002)(122000001)(26005)(9686003)(4326008)(52536014)(5660300002)(7696005)(8936002)(86362001)(110136005)(66556008)(38070700005)(76116006)(66446008)(8676002)(2906002)(6506007)(64756008)(66476007)(316002)(66946007)(558084003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3EroL+If9z2+njXRskayS+NqPyRo7h0DTdEmJfX25mlKT+/675KVKGcn1Um8?=
 =?us-ascii?Q?g2e88Xex2enz2djjMkttLWeb3SAUX1djvVLy31syGGdKPnebpjVp1jhKM4kn?=
 =?us-ascii?Q?mwlAoCcimJRHmX0E/3UxgdW/iVvUYRiM2amnLHNOvBAUk8bmH/hqehh1FH0T?=
 =?us-ascii?Q?+fWMyLbU1KUO5Nf8dO6eHFYiueCLRLnQNmNKC1n+EtJT5ZbXwTZ/elEw1CGO?=
 =?us-ascii?Q?W1Gbn0uEujU0wgQQnntJLCuVr5a+O2OCo3UmpaWvpyfqG6rBO6RQaYM/HHPA?=
 =?us-ascii?Q?a+W6vVR6JLVKsuW8dID2M6BYLrXir9dJ5rkEEstnPdx5igs8zRfWe8mzBDl1?=
 =?us-ascii?Q?uSFBQzRTN3k0Mc9gW5axcxb0Y77J/clO3hXmJJ/fgZTCKo0bqV4sTw1K7OII?=
 =?us-ascii?Q?lLcZHyV3k6fjB2/sS+6ymNELpo8Lw8rUKmvEnxpX2HWmBO3z+JGTYUo+7Dvq?=
 =?us-ascii?Q?D3hFHWUEbaf86cRbzbGeFXwIncmBvfYojQ7qQQ3vg5ADXBXNwJjzxMyNllJZ?=
 =?us-ascii?Q?2Ch4nWfnyuStqjzksfZ1RZuySAd5wA2B9snXCzzHKLk67dIibE7iQbONfvBu?=
 =?us-ascii?Q?3BQdktiX8CVxe5Azdim0+PZf3uNv0TL0C5lAuRf7US9zdf91IuHxwmYhzFDJ?=
 =?us-ascii?Q?CyoTVyLfoyEroti3FrELhhrih5GL0hTVMbFxdfqkHwFE5BQJqk/ocOYiRlmM?=
 =?us-ascii?Q?0J0JuLb2noPvdZgY/RPyIDo+zSCnd3DH2XC+OFuJbihnyPTiZAFnvvyFOe3M?=
 =?us-ascii?Q?GNx827GPa6RA1U5qulhtmf5HkfcvgxZMXRP8jq1alpn2v9dZNRa6YZpFD3ke?=
 =?us-ascii?Q?AbyoQFnHdbFN9pjCf7vY2FVy9oCJbIpLncwzGGhAeJbyjMU5ssnseCMTjBtR?=
 =?us-ascii?Q?IqiQW1znn9GNc/29uwouvqjx2+P7pvxbhQ8ozbvAyyvPaRjmUs1N2VUwA/xl?=
 =?us-ascii?Q?FJLiQxkCz/BDWCy0+0tYMOPOlouweYgZzvetCM8szCzls0rO8QorVXgGnlfL?=
 =?us-ascii?Q?uH0pG4LtRqD+EuRvYae+IfqIYPoUXmSDmTTM1l+RdDDNr5p1qZojoK4LnoyR?=
 =?us-ascii?Q?ACv0zgdNrg/bJzaHPe+PxqMcbbLojhhWoIrSJ9mVqs2oicPrIsQEeFFGfI6x?=
 =?us-ascii?Q?AhYv7fKGcJcZRSZB860trE1gwJZSG13tyJyENP8HSQCIy78PfVMdeZdavUC0?=
 =?us-ascii?Q?Xh+KJW5X2M6GWX4/zjyniqxgg67iP3Z6f2JMQkKBeygiFt7YXJY7F36K9EQQ?=
 =?us-ascii?Q?+S4q2Knu+CFgkCyJCKyU+TbrmqN/WLsTHi9ivgHGgAzxu01zbXao66VPz3Af?=
 =?us-ascii?Q?+Y9c8hxpnj4Yk4aWyzuUvkqQ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5669.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e731e2-3c21-41a5-6f42-08d96f9df603
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2021 12:17:27.6320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hy7QrNd7zB+KRGAL5lwehkN0Xec5V6Dz5OSSEiKvLcnuWubHnlbjfwgdqyH7sdNeyj3EgSMY5lFdNBqc8hpW9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5669
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> From: Lucas Fryzek <lucas.fryzek@coreavi.com>
> ...
> Does the current igen6 driver support error injection on Tiger Lake? How =
can we
> test IBECC support on Tiger Lake?

No, the igen6 driver doesn't support real error injection. =20

-Qiuxu

