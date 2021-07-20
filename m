Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C673CF96C
	for <lists+linux-edac@lfdr.de>; Tue, 20 Jul 2021 14:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhGTLd0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 20 Jul 2021 07:33:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:33118 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235371AbhGTLdU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 20 Jul 2021 07:33:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="296785517"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="296785517"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 05:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="432141833"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2021 05:13:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 20 Jul 2021 05:13:45 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 20 Jul 2021 05:13:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 20 Jul 2021 05:13:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 20 Jul 2021 05:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yt9euCbKLd8czStY6hY2rzREaEExhR7KBpK/XUfN6otaF2FF2dzys7uyov0BUqrPX9rBAfvb9cU3u/ouhroyh0hIcxj0iEDZPMbgbZw5I2oVYgEhJqCL7zM7CmU6DrEP9LOTXCKa2XzHFUGpim+Oq2zcwSr48C2doI4GgsUMDIauAqeVAhSQOC3FYzx+uETtgNN/szZFmc+eyVDooQm8wLsWbehj+xvONVFsChLJvD4hhGKOovdYNHeKh1xO0LZc7zKLTr3OlvsLnQ0vcS+L7tQMRvUEscNgrJAKQySf+CDDklKhaLGwzKmBEWIyX8ARDVoz6Y6fAPA9NF44rIMC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l0sgwZ8xIUGlktMAJhIOnpLVchqfmInDOI96vEwSao=;
 b=muOPqB1lN0/P7aepDdrn15A/1u+rBTmxgAG8fEyK4fAW3K7oB05xzScVQnX1DU7XuFivQCOpKGcuXpI+rADXPX9aau6X5K3r2Kub98EK5uu3/0tj+nt9c2cjdstadjQ5jU6OHl4j7k1ejss5XgfS9cc959X0SKpHZsz9ST9v1gxT7994yitacmb9lVvOpBxO0Ou+WIra+gAM8RkavkUIBmulO/o5wTkL7/b00Ib563kb7ztwTFC84dkpldFa6saLd5yHJxBAxg+EhMLoG4WRMz79DEJYkx4KWbvZKopXyGSlsLu/4JcOp02l7Skv1kB1VJsz1aAWhRrHj0BWKTjFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l0sgwZ8xIUGlktMAJhIOnpLVchqfmInDOI96vEwSao=;
 b=S3gC13e8j9xnSL+SKkmiGJ+ejw3+IO75CSl2cg1AAL77mPeIw28cIXmpdn6LuTFz7yTM6GTBEyKAIo3OokLuszRcO961D4hnV0nf6PIOVOI2x0PijqRv3OZYk7HhsabWnVgQYBPlzbZb/oxzgCqqwgpRYtmBjoH+4icdKirl91U=
Received: from DM8PR11MB5669.namprd11.prod.outlook.com (2603:10b6:8:36::10) by
 DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Tue, 20 Jul 2021 12:13:38 +0000
Received: from DM8PR11MB5669.namprd11.prod.outlook.com
 ([fe80::9d48:b5ea:83dc:2b97]) by DM8PR11MB5669.namprd11.prod.outlook.com
 ([fe80::9d48:b5ea:83dc:2b97%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 12:13:38 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Subject: RE: [PATCH 3/7] EDAC/mc: Add new HBM2 memory type
Thread-Topic: [PATCH 3/7] EDAC/mc: Add new HBM2 memory type
Thread-Index: AQHXfN9g3bq+MffDR0eiB1M8/p7+KatKyi7wgAD8jFA=
Date:   Tue, 20 Jul 2021 12:13:37 +0000
Message-ID: <DM8PR11MB56699B74F47AF7EFB4FB997389E29@DM8PR11MB5669.namprd11.prod.outlook.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-4-nchatrad@amd.com>
 <20210719204758.GC19451@aus-x-yghannam.amd.com>
 <df4b694601a947d5b6f3d87c5d776807@intel.com>
In-Reply-To: <df4b694601a947d5b6f3d87c5d776807@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ac840aa-1a31-44e9-3024-08d94b77ce1c
x-ms-traffictypediagnostic: DM8PR11MB5655:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5655BECA42B35C4588DAB7E589E29@DM8PR11MB5655.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ldw3Je1Akww8emtbo2tymmtq9ugWKyXR7ZmmXVBtiSUN8Gmq02/ArTjc/LPbDTIdPiqwTd+HnVKtVijm5KyT8yDQ9A+QOajHmUxJe5nOgkU8EpzgVxO0Kuk9D1ESlHzx8EzZmwQM/TleQfsmmM7vL5aeyeHgXzPnxRSbcf33s7ltvBuIzDyOgjHOIMr0op5uhb+n7XHhb03Bfqpz9uoaLqSync9v6pTxUQmVc41UXFz+lRyhbkozNRpvUm4/eaG4eO4FBS7vfHzNervFQSchQEakWUNBoOqh2n9FhqylZ9mdXKQTvVwhtOAIjdbgJFYJ+IxsB8Y4QMUHnTDkXgJnb5BhyNJgJ7W0vckUaScvi05bmKH3YZcC3xxHQvPtDtI1YqIuSxOF2RfPKoZGpITx8Fx0rCkjEoI6+QwDUKMaFJ07QlGUyRow1/I82EwPEWEQF1/qrUnQKWibMwmGzfwRSv1DaHNtM2OQoaGHDITd1g3uHpRXBwyUMxrdXFziEdZIi8+5zVZG1bROk1YEQVCwubbrOLB7fLhxzf8d6XEClZknIqk3K9R+qyAgN2gWHXkq1/u9vyKVEJv/d6lVbzz3NRaWCam5ne21SFVaq4Wt3iRbnFV6WTOq+6JOHgQLkkCVOLu8Ug9ChwVSMkJFVfvmnAHmMjMBlkG/Ge8Rkd4D7avRgm4MXDZQN9/tP8/NhwtKL+2EGbdFEndRDtZdwIm+jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5669.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(122000001)(38100700002)(6506007)(26005)(9686003)(71200400001)(8676002)(76116006)(86362001)(4744005)(66556008)(316002)(66476007)(64756008)(66946007)(110136005)(54906003)(33656002)(8936002)(2906002)(7696005)(66446008)(5660300002)(55016002)(478600001)(186003)(4326008)(52536014)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tWLAAxQ0iB67gLWoM7bS5lYy4dTXsbEjGpZzeGCUIvKQ5C6HAPWWvJp5QBBV?=
 =?us-ascii?Q?DnHcUWAW37UIgZjdmQ+u4F/CuuRR+21E9WllWPQx/qRZjBLDjiMCP0vP548w?=
 =?us-ascii?Q?txImEkn0iMPqXm4XbJzcjJNS2PgTOGaXwLTH6L16rjxk5+mFXgbWcC6poBr/?=
 =?us-ascii?Q?/nZ5s1Amu4mIjHTJa6EwfWrkCt+3/htvlbScT6ND3DFnA3lt1nix3+x+cw6V?=
 =?us-ascii?Q?m0nvWW1gwRE/r+t+EraxAyiHd6x+6gzmxDz7ofcGH1kFxBnnV83ty1nbfURP?=
 =?us-ascii?Q?tIms9w2WzPvFckdkx0gDOyBuGM52ALivBZi1/lR4QRt+swgAhUKnLRANIrFj?=
 =?us-ascii?Q?YQ52fGL66NBECRN9W2I19bQOXWfktcpDw93MT3/TgTIJfxbF8LgHYHXC1YIM?=
 =?us-ascii?Q?KaGRIDyVf9HcvGqKuhl7W7z3E9S1ghgxbt9PEcD+8Cd86AOoTZUlAyJmfkF8?=
 =?us-ascii?Q?USvH9DdrU0eyKzr8/4vQJ+W67xuJhl/PwoB6l28dKo/O8px2GZo7ZjBMjzyH?=
 =?us-ascii?Q?SSMFK049diRSghm4EzvlvKCCoPNSyrjh9ypmnxGyfjD8UAGeZ10OloDfQ7Ca?=
 =?us-ascii?Q?DJLPLX7y397WK5k9J55ktBGYL86IWeLfnCytqrjqevkDm6faNPMYQO2iaG0k?=
 =?us-ascii?Q?tRwpnyT6yCxtxnpVjN5kaB4CZuCG3u2eJ69ZgJUDZpUIPZgYcJvrYIf5kPwU?=
 =?us-ascii?Q?73uHnJSPE3kOZhiOmzuOfFImISMEOXTny/BjdL89KSF4UFAQyRdoAgQ98wGV?=
 =?us-ascii?Q?vHTFzflNvDiyLMiA4x/+ZbL+L+O30psvVU/tvPv8i7CLBT1OfeqzNXTnhW0d?=
 =?us-ascii?Q?5EoblRJ4qwr20cOQJyb4gXJ8lTyStxT6yjjDYBcTWSjmv63xJibNPmgzeArm?=
 =?us-ascii?Q?wMPIg0IiJFKZDur4jS33PlHOX5Cqh506PecenXpKPYOkSSnM4NHjkba2YMhY?=
 =?us-ascii?Q?AmRIhAytGXFy3lhS8y1tA6hPQGphRl5bziugG7WpOzafMlKot1ixH7xsKPC/?=
 =?us-ascii?Q?ETbzPBG6l33jBkCTh0OodBLgOnowebI2cNkl3AtQYisuNyNS1+KDCUMVT3el?=
 =?us-ascii?Q?WRF4rQPBNNj9F5DKwPTp3ufEHY4uSGdvSkGqnDtESFx3tB8q1drutAdyaXSE?=
 =?us-ascii?Q?+T8/U8AOvMgoNmk93q+4jyeROa5GqKBnRNP5yRKeApCVyIpS9gBqprtTgP4Z?=
 =?us-ascii?Q?nFRcEyqckPsPC/fd+fe3Yniq0eQc74VCm8/6Ppn98LsFAIDU4QkPpow1ottm?=
 =?us-ascii?Q?bnlYmGhXBbxCGbA2yGRMTtZ+YJDxDPLMhQzHtD3DpWNPB9coeRrqhDX6RNiL?=
 =?us-ascii?Q?Wk8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5669.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac840aa-1a31-44e9-3024-08d94b77ce1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 12:13:37.9367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YODWzpL9HJstaYTEyt9rLzVT9NdxiS1KK3XlKrWTLRxdBI2PyfymR1Uzv8vuAs/PyK81jxsLRkiLsHRCats3lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5655
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> From: Luck, Tony <tony.luck@intel.com>
> ...
> That commit makes the normal vs. HBM error visible in the DIMM label (by
> prefixing the "MC" for memory controller with "HB".
>=20
> +       if (imc->hbm_mc)
> +               snprintf(dimm->label, sizeof(dimm->label),
> "CPU_SrcID#%u_HBMC#%u_Chan#%u",
> +                        imc->src_id, imc->lmc, chan);
> +       else
> +               snprintf(dimm->label, sizeof(dimm->label),
> "CPU_SrcID#%u_MC#%u_Chan#%u_DIMM#%u",
> +                        imc->src_id, imc->lmc, chan, dimmno);
>=20
> Perhaps we should also set the "type" of the DIMMs.  Qiuxu: opinion?

Yes, we should. I'll make a patch for it.=20

Thanks!
-Qiuxu
