Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D97A6F1CD6
	for <lists+linux-edac@lfdr.de>; Fri, 28 Apr 2023 18:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjD1Qny (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Apr 2023 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjD1Qnx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 28 Apr 2023 12:43:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C7F97
        for <linux-edac@vger.kernel.org>; Fri, 28 Apr 2023 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682700232; x=1714236232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Qcvf5+RCVgIZsE+37KsSetyz+lgKNzESwNePJWKS4E=;
  b=VkqgGUOvV1rbLVwRA3lRjXaKVGykdZsyIfD9/dXm5lc1Uwtv4iDR6J1i
   J8lL8e+9WiEEd841VXdGIV1Rs3TC+hK8KWknoTPg7j5r6eGqQ88G/wo85
   R67+Xt6RFN2znUT+fdr7NLdhXGoJPYUdTfMmN8dMSX5EumUFqkcwWU1TH
   DHcGdp9c5bHU8J5t40vJnmokPgLb91MQsLwFYvpS7tTycqu+AmG4vRGRW
   P9H76ppNAwc2OcI5qXi/N9zzkxSCISWHGBMQV3ipTVAHpnWj8JB1ZdkZm
   y0j/bQFpO42s0yoUI89q+5eE8PuCos3UWXn5wZwyP9HEnXuCRqorv0hjB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="328131758"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="328131758"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 09:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="688882440"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="688882440"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 28 Apr 2023 09:43:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 09:43:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 28 Apr 2023 09:43:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 28 Apr 2023 09:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0GiRA1Ft+ztfW5UsYjsB+x+lFc23ShKGI8p0ylpgH5Jx6KEs7EAr1coVjsboW1jpwxzPw+CaM+OtGY4XMyt6qOfCBz36izZ80SCD0Z2LU+v0IbP2kQLYOwxVhzbiNPRkcrMi99YOff7V7s/Y0CcK5GJyeV2wesPcfF8CoG0dACMqllaNqp9mH7kNh1RH50o7qakiYSWIWe7EWtNRLcidZjVCfLe3snxNYvObzxZ2r3H7DwZGuCldThfc2QcxHD5VuyWBz3srhSaxnlVBcttxqMcWLORqAp9lgTnlwAgRFe9yvqZTc8SYouL+8M/HkRuf1kkgikHm4tdHN+uJkvcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Qcvf5+RCVgIZsE+37KsSetyz+lgKNzESwNePJWKS4E=;
 b=mTm7XSoEaFwleuh5MdrPQnwSjFwDf5ac6Avp3gsdN/Owfn6WVhRcgzpCY7saT2yJ/kS6/gFzc5muBN+ojDKWyk/5aPflHNBZ00xdvPlH6EZHYDqZPeeNTJmALyjErIEtlL3SNYZt9Qm9rbqWZ1tj/kZulxNbNN/c+G22i3MhZaP4v5JpDhbXAEuLJ/ek3Xnxg8qKKFiLIpZsVi2Y0//8yOL0OT+zW03NxBHEfQVA2qyexLp8AnRvZvgoQqSWpMKn2RdpRSM9rl4hEcehi9tqGLtWuvne4/byfhPGkyoBJP0tT0b3/kbAyhGdd/pGionXjgi/f1DJQB0nSr2eW4iwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB6001.namprd11.prod.outlook.com (2603:10b6:208:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 16:43:46 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 16:43:46 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aristeu Rozanski <aris@ruivo.org>
CC:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "aris@redhat.com" <aris@redhat.com>
Subject: RE: [RFC PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [RFC PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZKeVgS+RUxFZo/k2Cv7a8Veq3q66i4AIggJ6eqgCAAA3xwA==
Date:   Fri, 28 Apr 2023 16:43:46 +0000
Message-ID: <SJ1PR11MB6083083A8C72CAC6E39DF924FC6B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <Y8WtE7BNJ0gTrqIS@cathedrallabs.org>
 <SJ1PR11MB6083410C8464DEC926C0BDB9FCC69@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230428155102.GE2449174@cathedrallabs.org>
In-Reply-To: <20230428155102.GE2449174@cathedrallabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB6001:EE_
x-ms-office365-filtering-correlation-id: 89dc04ac-71d6-43e8-7e2b-08db4807bc46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +4P1w6DD3MIpXMPaHbzZXIElhrehKtB8a1hHyCATSb5PTWAk/fUKdsL5jJyswwfYXP6lrPWPRPT0DZUO1ZZVq+dl1xeiPXVxS8NKX+b43zIHSuOeEan6mv01QxOFkLFmtujb/3Jyqtryxw52MDnncsdQJfkTkN5cVcDWKvnwXu8jWhfbkuy3/+d2MhtG69zygG/iacQMwDVNXk83nOUEXao7PzxWxpjdNYcvCEhodJq3uunZtVoLj6fD7T47QjBQTgN7bs0u9E8ERrfeYlOhfJD6zdFQfEL2WTwqUkab8dJcbthTIS8bF6t4EI7KLQA630fAWVS/sAa0O70YPF/QIcywG2bSPp+npx+VAAgIUPhhOWfuMkcVUEu365R5dGF81/vcd4r8GFzO1xboBNtdOcrbs7lE6J2q21HqNL0iKXnEUsktK2SbBEkcBU5yyRDiVLyWWYQpqxTwy1G56h6WGxo0oh0i3VCkEI6Nf7zTfy/86CjvdBtwChn5LuEsCPaycInP+lr/9oQe7QVl0Dlkg5/3FiWH37OSEGs6eUr47mjBcBYPQ40F6bAciASid93HxmgxHDD/xME4sRRlVayZe2oMDO2rgppWVRw6MvWPi11kfNYHq7RlV+Wfrzd3GFLX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(66476007)(6916009)(66446008)(4326008)(316002)(64756008)(478600001)(66946007)(66556008)(54906003)(76116006)(71200400001)(52536014)(7696005)(8676002)(55016003)(41300700001)(8936002)(5660300002)(4744005)(33656002)(2906002)(86362001)(82960400001)(38070700005)(122000001)(38100700002)(186003)(9686003)(6506007)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dOvzo3qr0socUFBWnbj5pQHMrnHEB6bksLW/yooYI2lJob3xt2BYTDYYl/jK?=
 =?us-ascii?Q?yMO68SngOhb8f/NOuRuZIgs/H3NQDexE96ljpR+7JkB8qu7goqJCm/1eVw0P?=
 =?us-ascii?Q?wRflqkzz1ev2R7Mei3LuHxvqHp08j2xhtk8dArQWUTf75SsVPA2MnBkL1uun?=
 =?us-ascii?Q?r2vwkeGQCnexPHp24KFZFAtBXSXeK8Zhp1E+Axjky1w1p9F406voe7WNrxDs?=
 =?us-ascii?Q?wmwtXd56V1fLSKcjTLco/o6iZyCN+Yeo/mGF7rujMM2V7IzeP9qQ5JqmuS5L?=
 =?us-ascii?Q?/cjzeB5QpSqoLxtKw158tu/Cue8HkcioC9+0uvYi7Z4ga+W1xOZIpOYUs3Zw?=
 =?us-ascii?Q?TcQ3uBcPdsuNZFgiZb8Je+6SYgOwn0sW7ZzERB4oeNiPcqpWgi9NmbCKJMpd?=
 =?us-ascii?Q?MEEcDJldbXmWQq9wZFW8JnhV4anxrt8ugQxuy6xpsgvEUlAoI5iVdUuc9uCk?=
 =?us-ascii?Q?eKvgoYvW/ctd5EMuGxJ4QdZxYu2hpTEhPX7KLiteKgdHQrpflOGHpdH/BRA/?=
 =?us-ascii?Q?zlv7Hxd+gNHGD8aRydj93WVXmoTQBpJb9hUga6FzZj9qlZ7FUkagr3NYSrAH?=
 =?us-ascii?Q?+X3gTplPdb745h1vKADGCLBCZeYifQYUyuYbc4vNfJmgPRwTPWlKhNMZiO8s?=
 =?us-ascii?Q?ZaQHsyEYM3RleqGSthscxE6HcYqS3JGfbyRhzWm5OFpLL+Y0vZwrbK66uAuQ?=
 =?us-ascii?Q?JLHR4MgM4m7PMRIMM8DjoDxAwuFsER2gDGuoIyA8w5VQC1ncg0zU7LzSzmYg?=
 =?us-ascii?Q?ZT92/MDHNz4utiaBRvZijxcYPA88UwltReABQjb21J62COVz0YbiO2iaESzc?=
 =?us-ascii?Q?Li1ksE71GqfSdFElze4LNJeb1AfyWcPY3JFxIRG+mQlO2BaoTt5ezyV9hTDe?=
 =?us-ascii?Q?A4f7VGbB72uThI9xMPyEs4Ve/7IJ2gwcVzncwEVrkoqCqqnjYY5hULbyT44P?=
 =?us-ascii?Q?gC58GWVzL9X4bDT96bmanC0gFyoVBmWYyhzRJxkUV8Cfd6sdipw5I6Mi2OMb?=
 =?us-ascii?Q?l6pJYGO36j3fhAoj4kd+RwqzbRsABaBe2HE4JIkQT79EGzkcEK1y+bVrnv5S?=
 =?us-ascii?Q?Rm1BMy44uwkwzbz162kvnFyh3eN9Hw6UCVRRD4wXkr8yR8BIz967hTntiPd3?=
 =?us-ascii?Q?KHDDSxWAZLUWZrY4Aj3gG5L8HETm0jLJB4gMq8TbV34ccfzJzOS/1dswBHB+?=
 =?us-ascii?Q?VGbIYd3yV+C8fWDsnTM4AoNolAt2LVX3kcfsw/N2gWZhMPhKHPScuLv5ec/G?=
 =?us-ascii?Q?DahHGGWCHiilyqWPMnSZLKD/4EgGdkMeABo97WwykRtWso0GqsRrE7EGEzio?=
 =?us-ascii?Q?rNw2WyXLrmZ781+6Elu+KOzkhRe2gJVfnJcSqH0k359LgqnPJcjOqWnIshYs?=
 =?us-ascii?Q?2J0ypPcYLzPDwI3eANAFNSh0ZaYR1GdR2XNAVcxOWABYQiDLF2ZJ1P9IIXgh?=
 =?us-ascii?Q?4wE11rD++ZEnrY5QE+MNpYZfaIjTPoGaC3T2qeSdRS7fzyRgL3IveOZrSfrv?=
 =?us-ascii?Q?BMrIzEEVUMvQ3/UaPo2yyZHn11+EEIghbNQ6OAOgCSmpDbmxBIr+UWP3eeJR?=
 =?us-ascii?Q?ll9jq0WCSrfCyfwExWQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dc04ac-71d6-43e8-7e2b-08db4807bc46
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 16:43:46.3163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIm/uKRn6BUkGjaGTbvb7n0wCxs7LOneaP7dUbpBJMK3yK8xwFQWlVPodtwCSKd5bQW4erZpQmERU08JkiooZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6001
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> One option to avoid this might be to change from a fixed five minute
> > polling interval to "five minute plus/minus rand(50) jiffies". Then eve=
n
> > if some CPUs did sync up, they'd quickly diverge again.
>
> I did experiment different ranges including forcing a minimum difference
> based on cpu number but eventually I'd see repeated events. Perhaps a
> combination would be acceptable? Set the first run of each cpu spaced bas=
ed on
> CPU number then use a spinlock to synchronize it? That way we minimize th=
e
> chance of a big number of CPUs stuck on the same lock but at same time
> guarantee we won't have duplicated events.

Aristeu,

Yes. A variable poll interval (to avoid CPUs all bunching together) with
the spinlock to serialize the cases where some CPUs do line up their
polling would work.

-Tony

