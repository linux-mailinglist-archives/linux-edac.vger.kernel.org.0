Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6601D73A52A
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jun 2023 17:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjFVPgI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jun 2023 11:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjFVPgD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Jun 2023 11:36:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215C11BF7;
        Thu, 22 Jun 2023 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687448161; x=1718984161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dyj4SeykY11snPRTEN/aGYstQHhK2ydlfJSFeO+QgYg=;
  b=UUfT0Gjmwc7pFw6PDQwo1EH5+0xLBkrhVjT184sVc0ltewEOl/07Tkr5
   TxcIpQ826EKqDYf3Wo1nIGSGCt7rArbFhLfT6shuknK5gVqUlLiT6SItj
   mjHd21bOR4b3xRwG0cTWqLSwLc1f5Hvw0k87I3V3GhUrrVFk87/H/M6LC
   VdWy4u5W44rJwMFtqaz4mmDnIouqCI5zFcnKna4X2Xf6kMowwHgaa0FGk
   gkhLjsMRWQ4og7UaXkH7SuT5dvxlAU6WGsM1N6yFm6+diS2qrPv89jAB/
   ntj9dri5I40VQtHNN+kZfAUy0vI+VomXbicnL31+xZgjnGpzODpIu9W+k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="390290090"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="390290090"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 08:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="889088705"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="889088705"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2023 08:35:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 08:35:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 08:35:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 08:35:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 08:35:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lk6/bbM7Yk/ODnVuaE7b96RwWuZr6Xh2XyS61v/DocTw+OJfxY2Hvwxj/LGk+0OJf7HlHiE6OGsOE8OIZMzAWVwEUSY9yZPWYZqRsL1Rb4IeyoGr9p77whxBhSJk+4ZvC37hKIx4q4xijxMaw2OG9raJu3QkFiyNFplm9uLIGbhtIoCXccmJpGLhJCSOW+obIWqAS3bbbmfe9gHtfa0967u03tbemwUAD2qZxqn9dsxEB8uU82lnGo7ljKaz5vGyyBhmaSdt4MLzsUdWcADirRWkvwvTj4/cAg+ZJpqT2mInKOe9T0lsiGl08l8a9+Uu7D1fRIrLns2f9l6BnDdzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSEhfwiSps9H5ws+3J8k1rjLQ9XhCWWeCwvS1FiYA1o=;
 b=FEsYtHn9Z1l0SJ0O1ViV4gfry/j8A3PTr28E0ledVcHKVvaCz3haOGH8lig/dqI8FeyPZytb7obbgEIBq4xvrjiweR77K+3QPhriv1bzhNowXhMLHAa469K3aokZYkno6M7dH8H+Wc0zfaPbft7GZayQgsChRv4Q5MqiYZh5q/kpetPObfexdbbMbCNOoSkM8/pGu5rSE2Wg5bEY0bXgxdmgNGANSBw0NyHjk5efPDtLe+rBkKW7Z3X7WtskE25Ch+DKCgT0ezHD/AOTRYo3VJkI5Okw6Fto0MypL0yNRrMY0w3T6EYGfILxa6xobMOYTj83pIkFrnifax++jnS1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB4819.namprd11.prod.outlook.com (2603:10b6:303:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:35:27 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 15:35:27 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
Thread-Topic: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
Thread-Index: AQHZpQwiSV5YEcM40EuivrL9zu2Y2a+W8n2Q
Date:   Thu, 22 Jun 2023 15:35:27 +0000
Message-ID: <SJ1PR11MB6083664BCFC8047A5FE8F6A9FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230622131841.3153672-1-yazen.ghannam@amd.com>
 <20230622131841.3153672-2-yazen.ghannam@amd.com>
In-Reply-To: <20230622131841.3153672-2-yazen.ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB4819:EE_
x-ms-office365-filtering-correlation-id: 47a8831a-40e9-47d7-852e-08db73364e1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9AjU/eyXIJcrbn0TP2iMKhbGpzeaX2qa9FfhwpqtyiaeWmGC5Z7qZBSRG7qwGtCYGYKaQKZnIb1JgS5LEwMVIAVkX7u390H5/xdM8UHXIGsO+B0JBJZpoAczVFgjqoq20D4VwvjIdmVuqg8DaEpUNR7LFWhz7ZUG0uB0kuhjgjIA05clC7I4c6n9AELXh2uqkmP2ZgUnlCoxIEdULvKayV7trAWIBC02dEir2SY5jNSM3AVg6Q8o8QzXn5OtV74KldDTLPdVMJSg6kmxmW8DiT64/Fpm3K5IThVahSTxFPLvxeuJdNacuqYezqSV3ZJ7PTeIz3+y+0VykveRwVzbhx3P4wHrbmoGDlHZMIJrZ3vH2Fblz5dT/uGl7KhVzKnqxGc6nUn15mi7aocBnkXk1TfgTphUmvx7uYp5OztZFvZmHxO1y5Ssinq0ZXTrhEAMgKuYPgcyWyDmBeQgFxnp/Vd4n8vqzQycmuxdbXtmBWRELbbyFsriD5bKX162VTJZF5lEyPu1hlzNPKgbR/HuSCkwI+iqrsbBDNZkuu/lMcvy1N8PUQoET5DMWEJo99yc2GdPNU2vZxvTE1Q6w3bXKFqvqM9/C9CjPM8j10wAcTbmHlo6JUJW9FGvE7kdGp89
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(82960400001)(9686003)(5660300002)(186003)(4744005)(71200400001)(52536014)(6506007)(478600001)(7696005)(26005)(122000001)(38070700005)(2906002)(38100700002)(8936002)(8676002)(41300700001)(66946007)(66556008)(66476007)(110136005)(54906003)(55016003)(33656002)(83380400001)(316002)(64756008)(86362001)(66446008)(76116006)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PtBsyWM7iRiVLu+zJ2zgPG6EFHjto6kbo+o9c/Fx1XR1JCJVIHmhQCbU/Yda?=
 =?us-ascii?Q?ZVHyPoEISmeQdUzWhoPKNqmaIJx1lVQ7PQ/oUDJW247KNTWaJ2TQmDgGmXXO?=
 =?us-ascii?Q?CFLKxuBGle1IgXSm849aDpWKMAV1UmNv/F3HIG22oAf+ShEeGK2eSeiOfdZW?=
 =?us-ascii?Q?uIKOv60IX8RUrG7+0xEVoaC5sVoD6wi//Vnp2WPHtNUnBf3mdVtsSlAUUtFD?=
 =?us-ascii?Q?4lWyMisYZchzCkYfQCt18VsX5OFNynjNTN4u9NTGE015K/ZQEUhbSY7kQSZh?=
 =?us-ascii?Q?I5oS52Ggi5GbbN+dqdJz2k7gQCMJmsW1fyeXhZ/9qSjwkrlD85iUiU44ML7x?=
 =?us-ascii?Q?fNe3bm8KSe0WbYVlhkW7H0crmwtVQ/THKAShd61C+IEA0NK04kaYTEVq56S0?=
 =?us-ascii?Q?OBMWLULZfDSe9VTXFjIxxXlfmv1hOZ979NBZy4Kz9FyRfg1r1MPYq0bt5Q2G?=
 =?us-ascii?Q?MVxnj+cvqf4Hp8F4/pXtyc8Bp9FSpvKVW2GiGHYqLglxmMzx6ALZtxXvMZTo?=
 =?us-ascii?Q?ZG8ut32UYtk22GAe+DBxItnfNEIPJhj+9FcWGO3mqPTB2GjVCZl7NlEUbsXA?=
 =?us-ascii?Q?DP/nWbtt2g7Crp6XrAZ1FAmLxgLgoj12483q9had+jmUrVv1Fk1FXuO6aH+Q?=
 =?us-ascii?Q?wMZKSO+PYLdQ+dFALoW5W3aejenX/6VYP9TAD+JPZZzpv28dgOv3aty8UwBi?=
 =?us-ascii?Q?3pdggppdOQHkEuAK8f3MTxXoOIwFbIIA2y2X2lToPDoxDIEVenSdOq9nOc6C?=
 =?us-ascii?Q?NRbQW6KxQi8ftEJURPDN2EaoTK/fNKc9BTX9DbZ7OsAsrGKsxmA5XatfcPTD?=
 =?us-ascii?Q?EkIRhgqebgdqWgd31JEj7juzdt5iUnOLF9/7PLm8y7IX7GuvOfYbjVEdiad9?=
 =?us-ascii?Q?GYHz49/FW4jiK5AsRV5CmYp51haCkadaO6UqdVmS4rX+TOuZ1dhxZIz3vHNh?=
 =?us-ascii?Q?TSuIPfA5fDK6StE8v0N8qxOyskDkziOJG0B7hWhE3fIGnjl+FG5wvQOKmi35?=
 =?us-ascii?Q?NAxv+EudBAlye7e6fOD87J+s0wDia+dYGpFolkW1QaFQ7wHhOBR5hTsWkgoH?=
 =?us-ascii?Q?S827G6IsqATRjj60lzjByA/zkTpHbTZDdKTp6dojalUKKvNBWeNHAfgJVBYw?=
 =?us-ascii?Q?lf0rRVHtXGIlwlAxZvU3LVR+lcOk+OT2TEx4JwgzzUIWWpqWxwtSkzjxSOwY?=
 =?us-ascii?Q?dlNR2cjsgS/gtLoC6nEZm3KzN0P8qR/JRVdeoZKLUAnRMQb/a3E8lrQGwkA1?=
 =?us-ascii?Q?YNPu8czkJomCgSVi3oHMYAjgoIKIFNjtrRsGJDRxqQDCUBLZ0NOjRxOk/50e?=
 =?us-ascii?Q?oyatIjj4OrL5sCOrB8TNwoxCQRjaGpEqKfgA1RLclNnbnpwbYpJBH8q59woB?=
 =?us-ascii?Q?qZnRpHNA73HglJuIhlZUE/EHTryLu82C+VlIjOL04W+E7iLljQ2SfoDridyP?=
 =?us-ascii?Q?jW3WgUFR3mRuL0miOh5BieBKnwOe3PhMDCYLIjCLrZM9EjZyC1f7eADRheTG?=
 =?us-ascii?Q?PJ3G8IvisVDiz+IX/tSMSdvfzSvo5jybV4Ffvj2kVbEUTBl8kM0S5XZh+sDf?=
 =?us-ascii?Q?BfpD6UTcdu/IMJ3yIcA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a8831a-40e9-47d7-852e-08db73364e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 15:35:27.8374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXjwm9AKJ1k/VlW/FRE0HCkBs2l2cXR5E6s/WeARJMmYN/EIHKQvkhQOjR1fxyUJ6V4e6Z8UYEHtvS+xE+d6Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4819
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

> All the above is done when the BERT is processed during late init. This
> can be scheduled on any CPU, and it may be preemptible.

> 2) mce_setup() will pull info from the executing CPU, so some info in
>   struct mce may be incorrect for the CPU with the error. For example,
>   in a dual-socket system, an error logged in socket 1 CPU but
>   processed by a socket 0 CPU will save the PPIN of the socket 0 CPU.

> Fix the first issue by locally disabling preemption before calling
> mce_setup().

It doesn't really fix the issue, it just makes the warnings go away.

The BERT record was created because some error crashed the
system. It's being parsed by a CPU that likely had nothing
to do with the actual error that occurred in the previous incarnation
of the OS.

If there is a CPER record in the BERT data that includes CPU
information, that would be the right thing to use. Alternatively
is there some invalid CPU value that could be loaded into the
"struct mce"?

-Tony
