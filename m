Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7F760D1D7
	for <lists+linux-edac@lfdr.de>; Tue, 25 Oct 2022 18:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiJYQqz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Oct 2022 12:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiJYQqv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Oct 2022 12:46:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52252DBE5C;
        Tue, 25 Oct 2022 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666716408; x=1698252408;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cr1JHrNyGhEp5yZrDUg1oJyZcfBxyKHH5K8Z6XfU0VI=;
  b=caL9m+aUxELU5udnRUvwIKKyDGGtW5XRw/Ium4Or4LKnHQLuXMr20dH3
   a6YzYJwVxR3mo+KSnaDPM+TQNbe1kMhiRgaKR8L7Gat1ie019yKzAGijk
   T+PFs4/akkiiXhhn91b5BEA6oE80UCErpV/PFIvrpMi2dWqNYNXAD67NC
   iVw3QEd6MgpnLJMxXnYFZ8JBy0VTnBDMVOEzon/bGO2CO4E9KJ/9mvN1g
   rPR+owwDnvEF/lkwsLlIgLofntjz5UrIRJIUFFuLnWNa8WLqb7DjLydgs
   M06Rs5fZmDW9uK3VYCVcB9Sf7HxFRNASu1ouPI/qBCB+1proejHJwBx+J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="305345697"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="305345697"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 09:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="960885475"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="960885475"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 25 Oct 2022 09:46:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 09:46:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 09:46:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 09:46:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 09:46:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJJMhc4Z0FbWTpaxEXg/msKVDoceIACiwwGnmRrnFVSaa1gII+SkS1rvHSczE/CBXOqh2ZMpYKORUg9Lom4AAopQ2aTT4KgdW3NTsowYASqA9mvL5oLpvldvOZSMAriYnLJJrCg6dsc4di9nIz5b2e4U10XXefpSiS1tyg7wnymS/PunnG/Anl2eD7IopO9Xx9dVnPDhOZ17FR1BbI55POce3VP5AFdZnEeI1yWCA0YJ+z00rUI7/haGoegCJ2WRtHWk3AzAbYiUCLkoa6uZn4LmiY8inWD3xNk9opknBW3JApWSA11DjpFVX1QL/5AbdCe7F4UtPcuBRrBHLgtjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cr1JHrNyGhEp5yZrDUg1oJyZcfBxyKHH5K8Z6XfU0VI=;
 b=FqAIzazmLhEQcTxW8JBTWzLvP0DhzsT2NvLA4+cusM5Rb0/gaQjqufAAavDCvp7yPlmi0ae2XYOgALzVd0XuyJg5BvUBwT8TZdtr7QmH+fvhX9m5uNt+hZliE51bJF3UE/5l5fbEFjT7f+jIUDJAHiqTqjVYJqnjVr60ofkZa7UyEB1F0TDO22fsoc7Y8gtUhnS83PI6FyZlLuJlGQ/7OMVKkSCvtncBi3Hs5suwYzjiaqkFZy8+akclaDdv9nUacJT7cdQQCuuu47ORNGdYBPaL0GiBLVyh3T0VWzZeln0LMvF1n6A05/blCW19avPSUnHGfQ/4LMXj3G4lgMpn0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 25 Oct
 2022 16:46:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%6]) with mapi id 15.20.5723.033; Tue, 25 Oct 2022
 16:46:28 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Topic: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Index: AQHYjHDb+eGrTrYjV0q4Ak2q6+c136159KGAgApwm4CAAFH9AIAXBOsAgIKw4QCAAEkuuoAABiIggAAIhICAAAIP0IAABBTAgAE7p4CAAAKiUA==
Date:   Tue, 25 Oct 2022 16:46:28 +0000
Message-ID: <SJ1PR11MB608397CDE65551043EE3B44AFC319@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <YtUgb2Y/H/Wq9yIn@zn.tnic> <YtVlNrW58cFmksln@zn.tnic>
 <YukW/IltcCRwvSM4@yaz-fattaah> <Y1a4prRIYNw8GIkm@zn.tnic>
 <Y1a/lCVnlTMk8p75@agluck-desk3.sc.intel.com> <Y1b15vnE/Pd1U4r8@zn.tnic>
 <SJ1PR11MB608390D539CD4B405A195344FC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y1cCU9UqGG7nl8cy@zn.tnic>
 <SJ1PR11MB6083DBDAA90E1E03EC7A9EEAFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083A794C876D6F44E530CAFFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y1gQQ8gh1CJf0Tuy@yaz-fattaah>
In-Reply-To: <Y1gQQ8gh1CJf0Tuy@yaz-fattaah>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB7145:EE_
x-ms-office365-filtering-correlation-id: f7281006-5a01-42ae-3085-08dab6a8769a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3iHOc5wLKeJ+SvaWEPgO0//FSQ+57C4Cx3OlDtImePLvGPT1oHZo4gmp5sKEgNh0RL4KOhZ5IU6j/KlcBQXfSX2URsJlbdSF2p8lOsfM3R5UFROOTnOnfUH9GRbR4/PMCacnSlEaASlISsrvfra3emeFnIF4pAmQExh9u6ni+JcSG7dLilqrHxXDTZiFgCwTbPDRBSZQ9vqoZ9zZMrWe9OAxgFjiGxyQsq3+xkJ8YJ12eLyi69nWGCbdpDQ/uQ3iPtU8Mg1G2JuAc9uSnPg+/KczRe+40N/8zvUbGHacnCm33j8htn54d1gfztKjUMwmdrv6jS75FrAtXN0W9s81rUk/NpZGlxPR9DAaS/8q1in42zIemfCqkoVXdmF+QKyy2gCeRXWm8N6CRr++ioEcr8lwOnIoRLQfl/Na9UgbnqxkouXkng/WyModD9d022htQpehDsXnuT8XgLIwSTiByCj+kNgyOOHvDPPm8wW9Yav4Sdx41N/4qxezyEDRX8l8JI54Vyd/zMbMauaYyAr4JAuPCpH3oDGZIY9trXDzZA5d2b4OURwBC/hFl7GE1mhSKOYj80+jg0vxzJIlLZfKMYzh40xizjPgHnqkSuoD/j/9sGpvgcpcnvHfvNVFDqs/8PuVJTv7MxWgLW3A0KHOP37Da3uWRcR6gaFIqK0nxSuRSFlDzNfrEmvbPpXjrQWDNp9DGSN8WPDiJxzG/QL3yqdN/DLEaOtiS1TBaFLEKHKZGRioXH7CQlZYWOukSLgMz12iIypSV9mPNor2SgkFkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(82960400001)(83380400001)(8936002)(38070700005)(64756008)(52536014)(41300700001)(4744005)(55016003)(76116006)(5660300002)(33656002)(66946007)(316002)(66476007)(66556008)(66446008)(4326008)(8676002)(26005)(6916009)(54906003)(2906002)(9686003)(186003)(7696005)(86362001)(71200400001)(122000001)(478600001)(6506007)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1gr2dHgdk8HLXZomOK3+oAY9AqBhBsQR2xddhZr4vE41FrU/9Zw9Q0DhbPRN?=
 =?us-ascii?Q?a5PxVCb2c3Wl2cBAoFRye79F98RjKWUUrY3qc05eCoPQqHSgiTKwzxs2Iji9?=
 =?us-ascii?Q?n5SCXEDI2JkNIwy97Gqb73rRWfoXtOeeDAdX28bzMuQXBDN+r1GlvhlGRu9U?=
 =?us-ascii?Q?oU4Pjan8ZKhQ2CGyQKALxfZeKv+/Ide9h1Kpf9vQEcdSy737jUMVBFkiFV+c?=
 =?us-ascii?Q?/aBpUvv+IRk2+0mpVas5nRvcn1Ai344vwCbK3Vpt6tKdO5FxZ5kbRU+jA8fE?=
 =?us-ascii?Q?h07ocDF7UE4IIL5UPUx+ebDsGAeSE89053nTa7gIH1RgYWpDVrcDsFeYp82+?=
 =?us-ascii?Q?pNM4x2lB5MePesG+n/lkqXnri3/fyEa2TS0Xw8mL20HL1I4W4i4U8VlajJhP?=
 =?us-ascii?Q?vvVXTeOPJtTBLNSuUGBvZ5pGrkhNYX7456lk2hmk/7XnMbmO+f4IAZmyPkVc?=
 =?us-ascii?Q?PkaNFnWPTMicIAia99ryOKPT6zN6ijIOTWCmhLskT27ShrPcIdDr44tq+3OA?=
 =?us-ascii?Q?SaDuQqprSdRdmuhhHcPIXjj+D6q2pCj7AsCxoRZWz+6dk9iI/fLFe8w9ZJcz?=
 =?us-ascii?Q?zgLV8SjhfBKXBQNR+RgGK9aaooJ3o1oVpcdChG7b65tuJkZ10ObMnS5B8wr8?=
 =?us-ascii?Q?YwKXlJQkQ36adbsb4oFcsVj7QUM2ITAuezTXh2mEk7/FqwZepk1s9O+wsRNl?=
 =?us-ascii?Q?0v3LlxdWkZ5sQ8oFdBU7Hm+Pfe3JC2ETBDDS4ekODpMeDKwkbh+avH5yFjTI?=
 =?us-ascii?Q?09seX3Vmb6uSRZJZ+emoj8oS4xbuQOMbr3LR1dnsBQIHHjG4ckf4q5DUMZGq?=
 =?us-ascii?Q?CKxt2Kqo9TN9wBatbeRWiKQ1ugEdFWGbOke6S9mrhkb6qjhHkf2qhvFAldOZ?=
 =?us-ascii?Q?pQ/OV9KZQa3cEHfy7oyCGZpdklym2U0Ir467ShSx/DgNst6W8KayWYVdvVf5?=
 =?us-ascii?Q?+WbViBrBunSpG5UipBAUiox00Y9JyBdzhaa+m1lQ+9sedirtA9t8f6PFQLc1?=
 =?us-ascii?Q?zaqSD/XTjFm+zWmVwXgmmVYnTxHZKprLHU3aEr2sXZc21XeZ6kS2Fce8065q?=
 =?us-ascii?Q?4haEYS/JjjOI86NghbZg7Ejtnf0LYMytqM2A/Ont+TSioszoc86YjiD4tTnb?=
 =?us-ascii?Q?8rY1hrK7T8vyCa+4bUT6/vMjaWo+VXYUXOxMqU3I1aDcKkr3tXoGAz3xaF4M?=
 =?us-ascii?Q?kMucNwVjG/YvTANRrFSZ0tZ7EPJS+tiG0gpMTq2AYybHBRW0Hez5H7ViZHNU?=
 =?us-ascii?Q?Th3qBnAiIXJwU/qYN6ZWrXwE7vPQAOI19tzgfvM2qQlGNMIkfSFRiy7+Arnz?=
 =?us-ascii?Q?fLv/Zq0RqOqzA8X2/+egy2JOz2AW2SrQXHPHmDH3vZE0VNjQcbn53B7m/wt9?=
 =?us-ascii?Q?P473bKJm1AMAcQ8e5dWCW0xE2+Bu2Gaig5mVoxSRmauGyFNliPNo20Fd3dDF?=
 =?us-ascii?Q?PfYZ5byOH6qq5aw3qeM4mN3M5keYEC5wZskBRaNwtsTOg4wFLB9/O6yKDSll?=
 =?us-ascii?Q?fnA1QbfQUW+I6JhomQ0swUAP8ALDQ15xMDHJjrDimbWX408P8/mG3baCGfQK?=
 =?us-ascii?Q?gBlaV56w1IsyacJ6uW0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7281006-5a01-42ae-3085-08dab6a8769a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 16:46:28.6767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diMahdoQSGx+9HJRwcutSInuq+2M+Gie6kgSyq2egf0jW38ga4h08675wE6Fhzu5TNRpYQ6PYBF4iNXytJVkgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> I do like the suggestion from Boris to have a length and vendor data in s=
truct
> mce. This should keep mcelog happy while letting us treat struct mce as a
> semi-internal kernel structure. Also, this avoids having to mess around w=
ith
> all the notifier chain definitions.
>
> I'll start working on an implementation if that's okay with you all. I'll
> include kernel and rasdaemon patches together so we can have context for
> discussion.

Sounds good to me. I'll work on the mcelog changes once you have some
agreed definition for the "struct mce" changes.

-Tony
