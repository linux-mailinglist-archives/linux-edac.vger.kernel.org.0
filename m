Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED7B6C7005
	for <lists+linux-edac@lfdr.de>; Thu, 23 Mar 2023 19:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjCWSKi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Mar 2023 14:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjCWSKh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Mar 2023 14:10:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A4DA270;
        Thu, 23 Mar 2023 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679595036; x=1711131036;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mimvpeuP4GtEQCUNmtMuT/15NsFNMavy25ouuV9bGcA=;
  b=MKjHFI9yeR10tCYi5WYWEsZi+DJZ3fQu+gCxGbFJGdZdrMihXt1Fvf5S
   HMBo6cuF4SxJSD+uGjR5BrMB5m5JYsfbv4H/kyp5iYr+XuOY/3fXG4mUj
   ill9SIn16rpfoBH+My3pT5Nc8rSvsOjdNAS9QzgBRQ/xrR+JM5VTpWUkT
   Ww70Ge6Z2rDvdBqSbCeBs9PezXYqlyQIGqPWIN8fK/+43evj5wZW7tD+Z
   MsEyICiu+7Sw5LVnm/g2wtRI1fkmEXoUSW1zD8b7BDPN65WdVmBTNDH41
   l0kzNMTa9beRLGssk9pyaAzApcfM/jhbcguLvI03uO1My8+tM7HR+Av8h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402161225"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="402161225"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 11:10:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="771574031"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="771574031"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Mar 2023 11:10:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 11:10:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 11:10:33 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 11:10:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxWCv2V0jncm26RLTxXN7n2BIXu2+mrLJdxIN3RUMIBjltc6PRWQvMcKiUmd3+XLtk2MxNNeH4NtmEGui+axhnx6wDxcT23T5ZsAulKNlm3kyNevH0RGvi6iB8T/1wWj2F3hoIrnkQR95PS76iAzNT+TmooVu7AX+jZMKNZoeHBLCiXShLFwo18tb0DLte+17qhvwlTWMJUbHY0eg/30SOsj1YZEnXFOVpwKTiu5jXO3p5jGmd5NKhdIfD57s1mBZ+d+EqCM64om5vXA+XlpUz6TBByMz9VEZZ9uvG3DMuBZHyLtQbUCNCCIJ/L4f8OgX4c5KY2CNI2GWFdAUn0QFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtsVpVBVPUnJhIYpV2vZlSJgZH+e6ezq4LQfZelopjY=;
 b=RO3PqtAJ9ex3Vc3W8bz3vKmtMX1hAYMMQYmfhcJCJq9As7NxfPfbBgD0exrd9dIIpYCe8JzJjfZiiT11HNnc5ekGlq6eJYkaXuZXwZelJpNW/kFqj+sb8OZ+tbql1zbeXP7ozyhwvd/LqG141ua3/hsJyGRTH572805QrAP+PF/SEz9Pxwiiur7+Mq1vhZlOxsetu3lCA/Qqk9bghS8Sb5PADlNzUIhMGn7twyY252bVXQST0klQVd1Wzbl7TKC3RKD0oUib0YF7ao7ZW2sv5ps40IcvAUtSL7YnW5TcgxxESGJKO7cY48qDlu0WMPS2zBbzXRjLAOaA5rBV0+766A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6675.namprd11.prod.outlook.com (2603:10b6:510:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 18:10:31 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5%7]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 18:10:31 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v3 4/5] x86/mce: Move storm handling to core.
Thread-Topic: [PATCH v3 4/5] x86/mce: Move storm handling to core.
Thread-Index: AQHZWPTgJ4wIXq7BtEGVPo9uGmSDaK8IhfAAgAArnhA=
Date:   Thu, 23 Mar 2023 18:10:31 +0000
Message-ID: <SJ1PR11MB60835D7F85097FEF454DD74CFC879@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <ZBR+GMH0olGoDMGs@yaz-fattaah>
 <20230317172042.117201-1-tony.luck@intel.com>
 <20230317172042.117201-5-tony.luck@intel.com>
 <ZBxvyqb5Mnt13341@yaz-khff.amd.com>
In-Reply-To: <ZBxvyqb5Mnt13341@yaz-khff.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6675:EE_
x-ms-office365-filtering-correlation-id: b83dd2a0-f7f7-4195-e10f-08db2bc9e3c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHj3BFvvJsz1MJaqs1sGOwmAEyD+KbMTdC45QtNrrk49oGZihqv/hUgp7rNcV3XzHLeocukYTN6gX9mv4D1cm5MiBjJhMWTl/1OwPFqbrnwbl0q/wde+ZkGM86jG+2/AMliLpT/Niz3M4z4GuLFyGlj86TeDCNxIOcnpJpGKrmMF3n/yNamcKIgIK+6QmDUy2GiOVpqH6T9sUo14AQ1Wo+yuY926eal0f+ul0QBLXQ5W6dCylT3KCLlJKqALLhuDtEZvPlWVarYqOIauIo8wHrHzsvH6Zen7t/005Wn/XIULtkG8RANUl1Q0YVm5JX1w/4feUqWIemNdzdYTaNl8MM143vFUCrKunm0HmlvEMx1uuDOYDqTcZBFQdsalDutxsbtRvlqAtPMpgha+f9B9Dc/grrF8svK0MFQ66uEaMFY3PpOcy7VPcJWxSSgMK6Q1/0SyGhp7Bqcsjj/gO9KxRivChqekhqYnXKNxh6oKfVLoIdDzG5rArAQes8yb0mWPHIw9T9p0lqz5/vgCe9HWFOpAlZZnM8qReqtgHajLx00mQYZI8NhIazkDc0PSHUxvPG0XuyoJzaWx9/IlwGK3iCpM6ZRJsbIv+xytICu995+Zwm25ubV+A+B9vHWEyRtgIRIRf3hTOFrxFb1PVqOTKYqZ0fEqmuDozMqnZVm7LWMcjVvgImyN0+hTu0zqnS8GF5cfyQqOvfnn5XCxv8lPWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199018)(82960400001)(8676002)(38070700005)(33656002)(86362001)(122000001)(7696005)(38100700002)(66446008)(66556008)(41300700001)(4744005)(52536014)(5660300002)(2906002)(64756008)(6916009)(4326008)(66476007)(55016003)(8936002)(186003)(9686003)(83380400001)(54906003)(66946007)(6506007)(76116006)(478600001)(316002)(71200400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ge5PngVrmTCdodRY2Ga1tU/eC8rEdvwbSzNB/yFKt42f782NlVMzXh5R8q7q?=
 =?us-ascii?Q?7NWEuSs5m/7wcVAZevQVX7wm4o9q3pepAn/QU5pGt7erTzXbUnqe6rEkz49x?=
 =?us-ascii?Q?/pdnhApZJQ1ni6DcbufsrZwo7rdjzAp3VuqyJzrDxgQxSQSKckkbfbiBC29d?=
 =?us-ascii?Q?cOXJUdAY0/7+eZipXmkPhCpIWhcU3/rWqz9+PgJ90wQhbTm+vBQbW02uelUk?=
 =?us-ascii?Q?C4FuVCb92gTsDgN0K9tcwgfC7TQYNGVRKDqAkLiuzQHmocz990ZNwOq785in?=
 =?us-ascii?Q?0Ur32TIbz/LAPdqT5MeSipb2u6T6qVjvxyxeTGIzTm8yGvluxArBGS6doImP?=
 =?us-ascii?Q?qMUR8m6q3Yey9kU5fxwhZx6K5bGodq1/xy27hBDkRcgwlpgIvOUi2QDKLxCB?=
 =?us-ascii?Q?nkonNT7oq4mJKelerYy73kVwBZzGqSibs5/UwQApHuIvG19tTa7o7TrspiM9?=
 =?us-ascii?Q?q6dqkhaXGHeFmOjGK1DuEsY0u6hPdb3D8l6BK/44CRikgnCc9BH8DSpROMVn?=
 =?us-ascii?Q?1lGAna6v0qaIAOtrANHzQqwQl08SAmooKFomwaL9ZciCP4laAsjTWd7QhuU/?=
 =?us-ascii?Q?IqPl73XiwtBbYNESjmxZVD8ZTv24zJsBn//qwD/Oskd1RNimR3CbW67IfHHr?=
 =?us-ascii?Q?Vi73qOvPpBPNloCxUon0/sscIRK2LvyUEpva5Tvn91Rm1iwQ7S9uXP2byD2H?=
 =?us-ascii?Q?zIZ438jzfOJQj65kcEVLBBobQxUPKMrKEaBIcP6HciFERQqTWyd770tYteMa?=
 =?us-ascii?Q?jAAMqu0tRuqrXcupJ7RWGzePWcH7TV6+iThfT65Y0yNpFvtYqYNL9s6IvczW?=
 =?us-ascii?Q?pt9qrPbDXOox4hHjyMBRg4ouVGEIdbivdXOSv5fewcGH2BVe8yq7T3nCC7QQ?=
 =?us-ascii?Q?HAO5rlZUys1yI3ivmHR+cPqDFsNV+Ov1zABJHcYLu3UoXlR1BHTLdZ7CPA6g?=
 =?us-ascii?Q?7oeKijTQNt6kTA1ezEDbSo6SwSMhtj3UP6BtZ92ZgjlRZv+rPlAEn1Gr1xP6?=
 =?us-ascii?Q?QCKY1iVvUu0AvpsLVMPOoZkrig48FZXZ2Ggb84g5wsO5S/ZZTM4AbtfGZdzS?=
 =?us-ascii?Q?jUyxEfXCFVTjB8yaIMrANCDxrdRwFvfSgfoTenPRqdLardbe9QaMn2E0UWEs?=
 =?us-ascii?Q?XTOrVmtAreP9lYF/bKXmv5OmA4CoIxR+Rw7wkrDaxX6BZocTJ6OZHKIdotOl?=
 =?us-ascii?Q?NMqqsq+0YKPLeQzPpMNm66XBEiTtNQa81XbQY0QbL1RbkJa9MhRvxqZHtcZv?=
 =?us-ascii?Q?hz+6oC0dZtZ+SdZhtIlGJJDgf3m2ksjYk6AsdoQXkIUR1bFX1YAiYMRU6sls?=
 =?us-ascii?Q?hmgjrpwCBJELpGaB6FA0JLMWM4waK0Hp7UDvwf054ht1/wc7JXwTiirTUw0m?=
 =?us-ascii?Q?wP768Xnzd4e+eJPEWIHC3Qm90LNS6yzvw6JI+xMz6WrwcWt9kPAGBkvjj96K?=
 =?us-ascii?Q?NT4FkEhunm0Y1tNHtUiFjnPbx2oxTUpbrRbeUw+9E6qswqvN2G0r8Q34X+9W?=
 =?us-ascii?Q?wNmbdsOkg2fGW7CVyX6tKKljyS0TA3pSWK6swRKATs1FS/1A4W8bXGzEyP1a?=
 =?us-ascii?Q?sdPRZ+Z1wcVMdwMo+2I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83dd2a0-f7f7-4195-e10f-08db2bc9e3c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 18:10:31.2610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bnPcavIua+eYMOwZ3ryGzka8imAlVXGpI5aeMig3E629bu/3oqdKWcdoq837Yb52fopH/vW7CZ6Tx6NvJByqhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6675
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Can this patch and the previous two be squashed together?
>
> Like so?
>  Patch 1: Remove old code.
>  Patch 2: Add new common and Intel-specific code.
>  Patch 3: Add AMD-specific code.

Yazen,

Those three patches could be merged ... but they already seem big:

0002: 3 files changed, 158 insertions(+), 11 deletions(-)
0003: 3 files changed, 22 insertions(+), 2 deletions(-)
0004: 3 files changed, 100 insertions(+), 92 deletions(-)

Lumping them together wouldn't be the sum of those but would be worse (IMHO=
)

-Tony
