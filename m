Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EBB67B73F
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jan 2023 17:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbjAYQuG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 25 Jan 2023 11:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjAYQtw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 25 Jan 2023 11:49:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B97457C4;
        Wed, 25 Jan 2023 08:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674665379; x=1706201379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mi8PLdOah7c3sSUwKrYspxasFR47SsXpr+l9MKBLHvI=;
  b=PXnFIEuxPX+yH51kcIRzFzleH5GdOuYfF0xkCHat+atfyPKtEPUJYbuB
   oaIBgaVHt+gUfXfHZRf+kOMS1xBqBnahsP55CgVeuegbIiMv802ZUUehY
   +Bc1LfDItuyQmMvkn6nHGehILXoiDKU6u36qlX8CbkAb1Ekm3XtBMyCZN
   3XRuNBSBgXFj3E4tJb2qciwGxZTE+WDqtOIX4I/TDk7JPgUSWhZmzUWZh
   Juu4NbjuyRGSGLQBm+6A9XX0cSPNKtNYKMDU2OYC6yd/0PHueJainVrnD
   wJeV02t8QQCvDp1qt7zHTAGd13q540Rbk4zRMKqHjSZTqKayxZtFD94/p
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="391113462"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="391113462"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 08:49:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="693021300"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="693021300"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 25 Jan 2023 08:49:33 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 08:49:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 08:49:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 08:49:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 08:49:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPuQqEe6XgTfITZf8x4ycilhMTVePn8KV47PPW22xnbs2B+xJHqoPt9rHqrDXxC05uIfygBqgDUtL4AkPyWrLNaAPEkqIs2NuScTA8BpYNHaiRK+04BKKeztDWARSleqmY/dPXEnBzmPqqxGGaLo4ORZsnR2p/V3/mwYCPipiF1NWVyV5Z/r9HN2gShd6od1Ak53ganCHF+wzC48X22uiGIm1owXWg57kGLlNmvhntzRQc/OkI05ZBSgtyWMuRRE2PsC3ITu6axMq4pz3Jkka20QUkhl4GzGuc7Q0sR2oCbXrRfGzVH8vztWIhG8wlWL25qLhGbDXFsXpWHG6gOjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfEWuQy/b/2+ALmk4DDv07bUZ9Oq1v+jDrr1Ho9ltyE=;
 b=ZKpNahCiUq7rel8Rp/vXHIU4KN0YTjR9upf7vTPggs7q1UhYVXKfOcjxhYD8dK5v4v2Q0s1gTU8Oc6Ff9+LHslf8nBuh0awDdL4IJC/XtwxrVrg70eGY9WHEj9XURzkGa1fIkU1I6HhnZPeLIrB6qjLdsgDKggZWuxnH6UTsxaIZgVUOKtijypfenLYnR97XozcOAHU5kJwB6XuuyrEVaIbrlo7Zbf2wI2j0WIzUDyH98lDZZVjkHb4+o2B378wSO/NI96jqc7q48TH5mZdg061JgQLDpAHkcLr9LGwiFbXq9qY5VllNdRUD3iCgslektwPtnCbdHGwrjcGFNjiNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 16:49:30 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%7]) with mapi id 15.20.6043.021; Wed, 25 Jan 2023
 16:49:30 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@redhat.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Song, Youquan" <youquan.song@intel.com>,
        "Zhang, Li4" <li4.zhang@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] EDAC/Intel: Intel EDAC driver updates for "near"
 memory and new CPUs
Thread-Topic: [PATCH 0/5] EDAC/Intel: Intel EDAC driver updates for "near"
 memory and new CPUs
Thread-Index: AQHZJv8ZSGkJcWJIA0qHEgw3W1zotK6va4Ow
Date:   Wed, 25 Jan 2023 16:49:30 +0000
Message-ID: <SJ1PR11MB6083B8B169CF189F590F5BC0FCCE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230113032802.41752-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20230113032802.41752-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB4904:EE_
x-ms-office365-filtering-correlation-id: 69884e08-a831-4768-1aa1-08dafef42117
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZdUBCEzOZ9za+v62h0cqVVw2OTmZ+AGc5CxKen8AwxzrNg3HeSvZkgZHwQvdyeZbaxjjPoymMwz0Lf6UjCt/PXv4XQ6RSuoAum838CF/Tp+WdIECMAIMV4V54VIRXsyzti+fROqomMBo+rwjvQ5Bk3dMs7h+2OSUV2lO0T91TVmHOwvp/oMovCIRolLSehtTEmutUN+KcKzljCCIEacQT8CFlQCf4Dge5DG8C8is2uZS/Z61tAY1U8alMvCEQpVOCC/UC2Ri4s86ZuGiaL+amGyidxFNfT9bUX7dr4rApnbn/9Lghu3gd5o74+8XogsJrCClbFLY9OUn4uE4GcivGNtIa+gDT6SglQgl4zEkCtgN1Sa8CzmQICYf738jSilIGhtIA+caDX41YYty7HL7HohYW4TpOW9wQ4jjN65pCZAg8sWPoFoReAkjiFAOzSNvynHyp+VgLz0tJgYZq9JWdsFP4tUOm5K54cH5ewbgp1m0IWridtTl08kxLbyXNj96nQQIpXRYnSu7x/bYdHSXMk/TqSwwHBz4PU6RgvexcHxCO7WmoHGiIQ1WMo1K6ooBN8SpowBgkjygDSRdwuR+iFNOEYNiHTsSAacP9NaIpJvkYauxaw1jbid4fmeEXkO1qzh0TUoSkz4dnWshP+tVXkd4jDslwTmH+dpKH72PJEVa1n3CE5WxWjcDCtlYa9Kq4MGjLeBUW5rHOrPOK+f8Vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199018)(38100700002)(33656002)(26005)(5660300002)(4744005)(2906002)(7696005)(41300700001)(55016003)(86362001)(82960400001)(4326008)(8936002)(52536014)(6862004)(316002)(6506007)(186003)(8676002)(66476007)(66556008)(64756008)(54906003)(478600001)(66446008)(6636002)(66946007)(71200400001)(9686003)(76116006)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b+nTc5VJsWiJzeHX1q3ingduim/DqS2uOW6ePkqd4RyfZvYs4X84vJ37Lg7o?=
 =?us-ascii?Q?J9h0/pu9E0p9t+stJfaMavNrLC1c7Zh0eF7em5GXMV63e3X5BiIUnwlDNxxH?=
 =?us-ascii?Q?Y8iLm9oz/F6xf1vd4tUCLU8bdwnATag1B/KQCv05pNMzxFec9bTJYoxchSH7?=
 =?us-ascii?Q?QhvgjNWK2nUVbpBuSvIQg67tPm0cf6TC++RgMe6BnAFUvZn55cUIviU8H5VZ?=
 =?us-ascii?Q?khueAxq5xsokESkde9M1KcGjH4PTHxW7q+nVJXjvsvpI+TtrbVzOqa+gqGzk?=
 =?us-ascii?Q?Ahs49MHmYfEOna/CiGAYH9YShmrXAN/iWd5Kkvjx95qfiMTT5feIO75Kiov9?=
 =?us-ascii?Q?EO9bJB/VqxtaD/YQrUj991xzBINOCsmOycKusO8RZpyNDcSAZ18HKI/KF2YF?=
 =?us-ascii?Q?wbsYU0sme8VXRMHr9BmGxVAXLgtwSHTfohi1f3nWMPDv4LftVYHK8cHom0gR?=
 =?us-ascii?Q?5meXpQlW+qWOxAhMd4p7/v+rld0t1b9jpvR7/AIEyY93AemWG0aU/vCaU5r8?=
 =?us-ascii?Q?LFOdWuD5necLGZYK7nb6rQG4MduBVRhemn2u5ryvuS4e7ExVEjy+2qdToSJv?=
 =?us-ascii?Q?lkhe2pwvEpPsnk9l7JH6+mXW/MgOHjwaymZD+2fURm1fdxpKeYF+RHWeV/7Q?=
 =?us-ascii?Q?t2Xzo5h8ILdo7SVnBpgr5R86UGBYokutQY2eYvGytYXPj+jj1OjQ5S3z6pnU?=
 =?us-ascii?Q?Pi2lC1wpoY3qKXnCWjb/dFSb7wumku3fjcomgNrn21Kcz8lgrswoDb+eYouf?=
 =?us-ascii?Q?XLA+AnC8nzbrH10+M0D/Fof0/0qD5HQ31h77xteZep+5yHjo3dORFY+XCr/b?=
 =?us-ascii?Q?mapTDT0Xed3cxL05d1g9qOaxKOM+eQQTUIF8Ly1h0R8mk6w3bNhIY68m/55A?=
 =?us-ascii?Q?HqKGEG73YKcTUK7kQ5x742f21ms9uZJl1m8JDwFQciy/jOpqE8+KLByGBbBg?=
 =?us-ascii?Q?P1+KgIyxFGEzFiYL+Mza3gkQ9P0USeGBSdsfmvfwSajOWzLL6v8LRFVJIkzC?=
 =?us-ascii?Q?qmpHlGuhhgIGN1C2wYJWvz6Qwdi2vu6z4t0baoYaDQvfUX/hqgw/5ywyrNOO?=
 =?us-ascii?Q?USuulFmCzZdiH+07Bflr9AwWVWGsPKWCRVGGWw5PzCiQpx3aogF/TFJcv1z/?=
 =?us-ascii?Q?pburtcwOUiUA9DXMu+u5cIkY4So4Jdn8oKfO00ndQO/2Vopkh2dQQTvYkP9q?=
 =?us-ascii?Q?oPxrEQgW5W/wljda9M6YydiH8RHU3qCCZ7RGpnMGGdxWv31h5Qz+ysDBbUq+?=
 =?us-ascii?Q?Rp8xsgk4fYm2H7wKnAl8+Uarc+AUSQ2F9VYyfLSalYyqw26qJ1fWGiM5n7PB?=
 =?us-ascii?Q?Nb0RukH2DvSCUOgmqvW0CQARVown0Rbu7S29PTLiNbhwduS55QnI4hCFTY3k?=
 =?us-ascii?Q?Z5j4ykpUU1q4ocbkYD50siIdIiO+MKzmNtnKG6vFQg0Fr5Z5s3GvTivUh1aC?=
 =?us-ascii?Q?CHJYg159xzkuooHtBKWFk3yeSP+JOasP9We+G3Mb1mO49nelUtDzggPjj3ve?=
 =?us-ascii?Q?ijEB7ZUOdclyX2kFZNgI8AtLSwQsr8UYqXbCwnJnboYwrJvIVNQduaJHmWxi?=
 =?us-ascii?Q?F2H7QQ0bpRvO6nHODMTyuKtb2tc7OEYetNMyzWvL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69884e08-a831-4768-1aa1-08dafef42117
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 16:49:30.6359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJkQEOXomkt2gqwCcnBt+sdEOdb/dsAiExWlPjFz+gm5TuHH3zdl82G/bI8upYd69t4ZZAU0S0JkKD2xiL7s7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4904
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Patch 1: Enable EDAC support for "near" memory (e.g., HBM used as
>          cache for DDR) for Intel servers.
>
> Patch 2: Clean up some unreachable code after applying Patch 1.
>
> Patch 3: Add EDAC support for Intel Emerald Rapids server.
>
> Patch 4: Make common configurations used in i10nm_edac CPU model specific=
.
>          Prepare for Patch 5.
>
> Patch 5: Add EDAC support for Intel Granite Rapids server.

Series applied to ras tree (edac-drivers branch) with a couple of spelling =
fixes.

Thanks

-Tony
