Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB6A722B20
	for <lists+linux-edac@lfdr.de>; Mon,  5 Jun 2023 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjFEPd4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Jun 2023 11:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjFEPdz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Jun 2023 11:33:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3190AD
        for <linux-edac@vger.kernel.org>; Mon,  5 Jun 2023 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685979232; x=1717515232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Peg8riq3uOGIBASh3X3TZAXUOJ6+XUHjJXVLY5eIrI=;
  b=QTJ0nrOkq7mIPEe8C+eqFIE4MzE12uJ2cY1fGVku1vT/0Mo4CHXugiwU
   Mgcbd4YMEpefdjF/4KzsPxZt7H0O1SL4bKFy8aisdlqGwLXWZLbe1B9YJ
   qCZFZ9Q9OR9wjtt/ds0qowtfhHsqLiAvs0OzaRGL1aynbec6AEo+BWE8M
   sBhz5LC0uNJAf9EWhS9XWGojVpoX8RPEtljd7nmU/K92Y8jb18cnb4nfc
   VwuSvK7m4AbNRvcD6+Mt0dN8gQX5pkgHEFI/E0MV0zwU11PmDUY1nj9hw
   07d9ZghzHW9hs62JqrtY7AUqV9DYXyR7j0wucruEpp22oWI3ff3p7kxTs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="345993188"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="345993188"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="686167101"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="686167101"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 05 Jun 2023 08:33:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 08:33:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 08:33:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 08:33:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 08:33:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGwj10nj09crONS/UtyXWZjx+ix8Gs96MGROhTaMZVOIebgyW49C9EAmd3PE2BdZO51C3hqmqozxHse+yKdgTJSqi93Cgfc9ukFPfjzOJz0oyYdWXa/Bgs27k1xzIXqPodj/WY8keKASvvg/RE3JESIckUZ6BU1BOTEzBTxuibYBetlBy6aqdL2wYWSBofswT8CIemKdXtn5cpOc6oSpgZiDPAxp9JXljVRdG8fzOiFhGA4Pc932IvlKBOKGL3+QZ0W3s7TYBFBJDJ1QKBARBauxKjF/X3u6BMpJYi7Sb5z5b1jHOeJlXx1RwwltmsNTsf28yKu0MWIqDAtt4yRyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qa7bZFwpci+h6NLOX1G5Hz9mQrWOXYwhDPZgZPb1KTk=;
 b=L+b/S3boiHlqzem8BSrchFI/pxOpKK6RTmzd5mM9qxflHSego+SXRamoKJVMGkcwGw6+8wZ/pxPvPzWtK6i9t4abSHkqMZ6fYeb+h5ShJAJkKlR8gEoKUVScMh3hKE6aQ8vEFnjbxYPcgYI8Pp31Jg4FF4+/Vmfk2EiluYQOEIeZMiHHVbSw0ElTsGS7mwNEyUoFORe1Ylnm5UL1j1KmY7gPWFzwbi3+u9Ec4DvoYzdGNWrhvi2i5djGCFsp7i9uW7DG6cyFmb6rKAtkm/TcISNro53qIxrZOcXKHnfkWzfYw5Zq6e1BOyOeC4+mnYLbyHwqG5d6GklRoSjxocPxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 15:33:48 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8e5a:470a:d7dd:a012]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8e5a:470a:d7dd:a012%6]) with mapi id 15.20.6455.027; Mon, 5 Jun 2023
 15:33:48 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aristeu Rozanski <aris@ruivo.org>
CC:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: RE: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZhzo8HZ+8oxPq9k2uyIf0XEmMiK9ba0aAgAAjz7CAABk1AIAACA9ggAAMfoCAAALmcIAMM9WAgBL6hQCAAYhoUA==
Date:   Mon, 5 Jun 2023 15:33:48 +0000
Message-ID: <SJ1PR11MB60830E9036D6D0181CF9CFD4FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230515143225.GC4090740@cathedrallabs.org>
 <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
 <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
 <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
 <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230523141523.GL4090740@cathedrallabs.org>
 <20230604160442.GN4090740@cathedrallabs.org>
In-Reply-To: <20230604160442.GN4090740@cathedrallabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5326:EE_
x-ms-office365-filtering-correlation-id: 924c1a84-7d2d-468e-458c-08db65da41de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jXYgoJ2vejjY4yZPJMBqb5IKH0LQHJbGcTd8c3fHfop67Kjvwl/fOyVRnk/s10+3jHmzmWPncqS1TxdVczsTbWdijYLytGyefWEW4YV5n42ZS86PZgIu9MCRjjturwQS+6tlPUqzvJ8LtJtc4B/P4sdmdCzMwFlUz68WlyIdmMBvwqkmonswShiXgH3MS8xDdKQnWdQJf/e0yy+7c+lI9IVge14IB9He50mh31L37FWLrhAGPHPllaCzH3NkPxyv8VmjKh7J0QYYyWPFw8lcOmmQTbIKUkWsQUbLnSG9Qvy7xyGxOz3vGGhy/J39gi+vy7xj7d31+sUPcaqlO6aMMtDvM8wQGZkNiD7qmh14Dq5lpfhyNX7ZuhRZj+JRUkwzEPJKGtrYdipYEh7D27Xpuu2EwLhHv7cj4LT663eteMtey1Ri0944+n7QTX9lJ6+XLiNvRMRMzMzwScURc9xKlq8bQsP+gIR2ibIdGhk40RNU7QISSOA8TlWLox0N/vEVdz9kLme90Wpd4eUp9XERQWWdHPDtvksqEn54Tmg+pgg/upTJ/GZkzsq5G6RthFhYQOrWFHwxTX0qGHgBVz2QOBxwX1lNbdLcCHMpyA2vmCihSszjmVKiIL7QGlTI8MWx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199021)(55016003)(54906003)(478600001)(82960400001)(8676002)(8936002)(4326008)(66946007)(76116006)(66446008)(6916009)(122000001)(316002)(38100700002)(66476007)(64756008)(66556008)(41300700001)(186003)(83380400001)(71200400001)(7696005)(9686003)(26005)(6506007)(33656002)(86362001)(52536014)(5660300002)(2906002)(4744005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ym43fUpL9ZFICguOzaZxRKmO8IJLknMxJyGROmLsGV36THH1hJ72HbAdn+Bm?=
 =?us-ascii?Q?+fRrrzEVP6ut77ToE5hUAT4s2iXzNGTjCQmLOVnTO1RnK3S5+qwrOO73/58z?=
 =?us-ascii?Q?pzHZ86EKm5P7EBRwu34yP0tCN9TwSOyB8Als/cgeVNPn2ko5SDKBAK+4j+eu?=
 =?us-ascii?Q?tFpTOhiwKa3Evp5qbi8S7g2uKcbkm0xdPn1X3G6LKa+WWWfmbp2wRdCCRxwE?=
 =?us-ascii?Q?BK47ExQ8VtLqF3a82JNYwZTzp6lvZAwEVXHFQGq0kCcSQvhjz0NxzUrHCxcd?=
 =?us-ascii?Q?D6Zqmdr+NaAHe+GmkoDxFNoGxwKxKYZY/5AzXwhIUw0w5HlzEXsL8cMkkHWK?=
 =?us-ascii?Q?BNaEAOCLaMGCbVXnT65Hv2xl9ke5TjE5gOV/Ns0ZBiFQ7UlGyC6mX5oIoKMd?=
 =?us-ascii?Q?MLRX6i5S1KbZW7G1Y5DThFwCpCCrv1K1Xam7Kwww4EQvLlgsiQNl0IMZSnTf?=
 =?us-ascii?Q?fKDbdBNn1oxDsiwSVGbT8as4pUO4a+NgSKER+3EHoiApkrezqzKyD+eN7j9o?=
 =?us-ascii?Q?qjlprPtDySWXXW4QbJP6jhhKd8yJgJeJ3agvzZskmGJSexBV2o3AEGaUwoRQ?=
 =?us-ascii?Q?t0acKESy0QIbZUB3YlooNGGTcbtHm5wbAcjPcKs1cknNIwcqv7xepQ1/7oKR?=
 =?us-ascii?Q?w5jF2xWjK6562jK8M0SDm/fPlv4nqHIzPxCkLyBBjg51Hu0o6E96xBaQ+pxl?=
 =?us-ascii?Q?fsh2k4ixgKAselVuUVaY/+yiwPm2dSrRRyFsVU+ogDWofKMpo2Ur7lZzpZMO?=
 =?us-ascii?Q?erxLY6vIWyu7dNHsC4b3AYMUss4sP3G2Xz1ZWrr0/oph5MBbdW8XXBhyKBQr?=
 =?us-ascii?Q?voSlpaubT8znBy/kVYtX3ZFSX1HfayMVhSeD5zF0vNpczk2eqKHB4NZXLBVU?=
 =?us-ascii?Q?UnKQ9uEIFta6kKv+irkTV1ADjQKYx3Udr04SNsEMryB94Tvssxg3tqfhO9nz?=
 =?us-ascii?Q?fKcWCjkZxBgMVKIC7wxXIxhR/9IHwO4XQWKa2x8u4hblSsx3FkvmLK4ZaOgy?=
 =?us-ascii?Q?oOoajt7XNVofpn63HVxM85sBxWi9Z34jIDjr2a9uyGuYV36wrVlVz5VQmEgX?=
 =?us-ascii?Q?VkQrsme84ECWOMGjDk55ijRqEz9cGmqi3R0RjhmtuXbrTVmOYzPagQjaOM4L?=
 =?us-ascii?Q?zXJ/EZAqQClqokxmMVjR2ezPBjRX65cVfqosYSfV3q97EVoE0dAqjU1Dh4mi?=
 =?us-ascii?Q?Rk9hbRtR3r2Rjk7h2bYy9eH9EJ7WZmbbDxiXCp2UkUpRwCiOo08PKmy6L/GQ?=
 =?us-ascii?Q?77k3LbWL3vVTNR0OFg/9bPRNUWDEVCjbmPckqgWwarP0OOgWmG1KGmrQuqZa?=
 =?us-ascii?Q?lMN2XuRnHOcRBk13wFyEFHf+on2F/n4R4yGOwlZQ1zu/8jzj+jmgNLlwmE/8?=
 =?us-ascii?Q?b2SIpBMDaNbPozZnuZqMuH6CY0vf90Fwuc0GLt7ELb0K8eYJ3Dw2cBCf6bn+?=
 =?us-ascii?Q?E1gjoM0OLltvEHyBjSGkQvdJ/lZ+G4v2MJ4+nyn4XJbkBxdxVj2jsdkdvGD+?=
 =?us-ascii?Q?nj7ROUNZ9IG9+oWSH9xXoAzc4Y16O+KqyPzNhzkXS4Wza3o22OD8U5yE2r0d?=
 =?us-ascii?Q?NPp6yvgtkbDpC1bvKMo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924c1a84-7d2d-468e-458c-08db65da41de
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 15:33:48.5017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8gnNh+uiW1QwRo4mwodwuQn/MCaubHU/KvCJwkPOgGg/4T2xcn1e4FqF0gUg7dCYxTthqfxWI+BtsJb/neuFKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5326
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>> > I disabled CMCI for debugging reasons. Aristeu needs to comment on
>> > his use case.
>>=20
>> Got an answer from them. They disable it in two lines of products
>> (one uses IceLake, the other uses Sapphire Rapids) and in these lines
>> they can use thresholding to signal UCNA without signaling any corrected
>> events and it won't work with CMCI enabled. They did make Intel aware of
>> it (maybe you heard details about it? If not I can get them in contact w=
ith
>> you) but it's not certain if this can be fixed or not.

Since mce=3Dno_cmci is a supported mode, and end-users are making use
of it on production systems ... I think Linux needs a patch to prevent mult=
iple
CPUs logging the same error.

I don't have any other ideas on how to do that besides Aristeu's patch to a=
dd
a spinlock to prevent simultaneous access.  This isn't a hot path, and in m=
ost
cases not contended, so I don't see much downside.

-Tony
