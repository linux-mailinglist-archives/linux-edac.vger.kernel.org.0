Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49776E4F12
	for <lists+linux-edac@lfdr.de>; Mon, 17 Apr 2023 19:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjDQRTg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Apr 2023 13:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDQRTf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Apr 2023 13:19:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA6A172C;
        Mon, 17 Apr 2023 10:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681751943; x=1713287943;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wjz84Ng6pYMWfovkjaBo4+Q6LAslU2D3N0M7xgcrv/8=;
  b=W4lUsHJwOgt934Gn1UQtgmkcYvEshxXy0nrCt/YQeMd7CX1lFNRAEU0b
   cQjvSAqk6zQb4iDsJQcxDd1CfXUJV8jxDjFJQYo0h7IX4laQup80iBNNU
   VwVHgnQJr7ettnp7mfGlk1E3icdT9BGBFfCRrg3bM1zxClWfetR/mPZkB
   xxK+GgHArKQ/HMK6UFgtlnls9tGBsdfEyE11mSUTi4IlCZulIjcrXo+Ml
   a4CHz4N982IEYuCXk5JY5CyLMt8YDEXPnYxVaC8+AF3n7v0mh1zcUtKkF
   eBTlgCAyDNfKHQFNKXWjCPD+9omvxNha6ULW9EIowHyc6DCGsWP3B6DSl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346796656"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="346796656"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 10:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="865069994"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="865069994"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 17 Apr 2023 10:17:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 10:17:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 10:17:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 10:17:53 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 10:17:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZzpTHeVMxVxmzdpEASo/MIVdVzInhjFG/2AfElYEwVPMhd4cO20srpZh8WTNfTB4wwePBtYFcdvJcP7K+bvzrWWp4ryYMOo2DmuJZTrcL9BrJrfAuFS2R3/6nE+ZuRbgOXY/P1/CNISUgtKNET6omnq1kvouqF/InPBcG777/kOBpU+iy148M7umEFo0kNIOraziZJt3FHCX2Med2cQ6Hvr3qAnolILxXuCbsH5PR8hbUjjTYdoieImZ/OzVt1HJc5N0+7Cr5jEtPop4UzuvDSpXcBdUBUvvQIhITeR9VIp8wDWoXRaVdxX1hozlhfKOiNA9ZA8xC85CYP07qWSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjz84Ng6pYMWfovkjaBo4+Q6LAslU2D3N0M7xgcrv/8=;
 b=HCTM+zXzu89oR8EpvFFTknMKgXPjeqWwoAnXk58nYo4nARAHCstmr5ePYHts824gz3L51ToMOfNf3zLAVrVWVqvHI/kTfYDAC+vTKigYrsv5wLXjce9SfS2Eqh7+mCUt7I5hWYo2/F/cCFe3rCUVpgXg7x8som2Xl39ubKZqUMO6UDCu/oCColFPulJPpj3h2j57w+Y8Wxlv5B43nmpTnJl1A5WjyMYUJoMye44mlvlKcA97kYlln+DVUfdLxOxpd12XKQtJt+8dvzy2+f4k6oTKjrGtOuZxkNRmcXFEozjRhjUr61b0/f8jGBI9WCij1dOkB8luSrOm/JHn4GeBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BN9PR11MB5420.namprd11.prod.outlook.com (2603:10b6:408:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 17:17:51 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 17:17:51 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
Thread-Topic: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
Thread-Index: AQHZcUiOiGs+Y9zOZU23tA/yQJ0VrK8vvZSA
Date:   Mon, 17 Apr 2023 17:17:50 +0000
Message-ID: <SJ1PR11MB6083E6A167F4542AB439F09AFC9C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230417162006.3292715-1-yazen.ghannam@amd.com>
In-Reply-To: <20230417162006.3292715-1-yazen.ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BN9PR11MB5420:EE_
x-ms-office365-filtering-correlation-id: 04adf69c-1a91-47ad-2313-08db3f67ac5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A7PJqKobXlLaV2bvZKnnCdnKdhJkAOvI/dwxeC8fwq1RUr6tmqs7MLAgOxTwUgRBjuFBjJRaQvZ7NcT1Hh8iwYCWbx0fovPJHAg2dPObrpYBBqqfXoGdNr8cYcADmBU7j4sqipzlIvutDZENE2SgKzzqrHHQGrPLjFU3V5oyH5J7MKPVqOr8SaHE2vHyQwN0CPIk2q0qklTqVoFTzjXM3Esz3d6/jnRwdbK2/4jhmZMRQCBthaN7v5H0VN5tzIZvdKuf/1++r8sIGj+HKLl3MQWqQuJd/WDHgIsbeODG8kDb/wI9rYL+9UYvZUPVjmKsoi4+wVoVJs6hH1Axd1UwyUxEGRmW4zB38o/A/YcsJW6QL9gWb9NOzubP+hpfwul1B4PecUH55Mj6faEfUUIoR0WuI6Z9GqAPoObn21rHPijBLHEw3IQUBjrmlf6ESvDv9uMqXAfriu4kCMnGJGnYm85s4n7z4HL1oU7D+DCPEj509tpCRXphk+D2YkWqJqijrw6TONYtHKN79M1+o5WECSFa6TfGwt9FJNUDFRTNk1xang4x2m791ZA6Ti2sLkqCUvVPgSGBAs3RbJBQWPzJXCxDDU/+zrZqMET/zDZqgaf4W5a1CkEfEqHBb909cm6Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(38070700005)(52536014)(2906002)(4744005)(5660300002)(8936002)(8676002)(41300700001)(122000001)(55016003)(86362001)(33656002)(38100700002)(478600001)(54906003)(110136005)(26005)(6506007)(9686003)(186003)(71200400001)(7696005)(4326008)(64756008)(66446008)(66556008)(66476007)(66946007)(76116006)(82960400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sQDPKiZAaF5FUtOLpUdkFHjBrcqu1zZQDnV8AlqPJStfYzpI1luA4EP59hcu?=
 =?us-ascii?Q?cUimM1ohH2UdIhggvW+p14S3PsrWeQOnpuJ6Gi5++QBQo1QWzMVniSMrAg+c?=
 =?us-ascii?Q?qtQLkwTbFUw/nBmMtwoZrkAUbAfO4I1s5qhCvXqCD/y7cob2/IjP5JkkdrXI?=
 =?us-ascii?Q?mGyS0Y1MuMRmYDN0mU6s9GEBI1VJepZ4oWAT3udGFYc8Dk0lb3dX2zbmMHWt?=
 =?us-ascii?Q?1OaqXQfoZ4CcdwvFvMJJ/uN5RHGTmuxUblbWslcy3kidZrDS+ERT6v1CoscH?=
 =?us-ascii?Q?sMW6bH9sU9SGnmQhxe5GyL3Rgrab473uZRIOXy8U688pXxuCoUs9YOb2AxZ6?=
 =?us-ascii?Q?+NWYRsLITtCsDokilgDaVyNp2vckW1K+T6Dz9Vm7KEcoumGDwVJIaoNCeC5f?=
 =?us-ascii?Q?dnlmy2kWcWlv7SWyStUAYmGL4h1mXJ5KcaWqUOZfpSFMLHOBvQgrBT/vb+Vz?=
 =?us-ascii?Q?RjSGSU4BjsR+t0fPqh96Bg/WT/lbIvQZeNrHASyp8bYGQFJ7X8+yQyrglUZ4?=
 =?us-ascii?Q?bNTp1yqyBN8jzOt50oLox28zD8W6zm0XhxUYHi9UZ7nqTtQWPsYkGBaFoanG?=
 =?us-ascii?Q?1efuN6AvWdbMu4/QYnYXzEJa0T4ey+1zV4nWZ6R+5mqhp6zIuqSQfd3lD1ni?=
 =?us-ascii?Q?9WeaTvpq6FiBn9Qn/sjWKXH8lhJY+aKg866Gv0rsfskIHyiun3FcIF2InZAI?=
 =?us-ascii?Q?VMA9Ud1BP8pdU6CXIRBpMk4SUgl+rcuk/KVKaNf8sKOJB3kcqUPBcWdRLIpf?=
 =?us-ascii?Q?faYS2O0jPHmrBrMsdMUxbBzHbxdouTf4kY6MnM/pxq1xF3KogRM2p8ANJDum?=
 =?us-ascii?Q?a2iGvFJWNbH6k0PqfBP9QJBOz6LhmiUHsPGZHvYimzhFUA0ZlDYvQnssN6JO?=
 =?us-ascii?Q?UPJ4p4zyC0IZ1YSo/ZxC2iXrWjcw6Ql20SBDdvoLfJodj2y3k7A7BA73PMqz?=
 =?us-ascii?Q?KSvQcEELT3fbWSwTiB06uAs5noJiVyPM4nCJLCRHgrsx7UOwhDIH+yFhg/EY?=
 =?us-ascii?Q?2nS5U6yh58QLvnchCcD//K19J/5FjY1b0NNu8LM/Hv8DtL+0f095+slnd8Ot?=
 =?us-ascii?Q?WUrQlF/HRyvam8UzZxDvfGaMc00lrkCca6MwToQQI3D1N7acXw+ZzD+OFLkL?=
 =?us-ascii?Q?8YgMKFSvbj8ADjhmj82e+79FgByNUiNMeccqR3+F0RZcTGSOJsj2BO6i17ER?=
 =?us-ascii?Q?su1mfNMPoAIbqpU/oiq+hqJTgp3EsiijfWwf0nw1racEy39ppX8Lbu7qdOmV?=
 =?us-ascii?Q?lYIw9f/JHJiixTYMF9KlvKKTqf1P33zE7FQVNZ46eFLOHnkbUdriDsi0I67S?=
 =?us-ascii?Q?URWICAfBCT+E0x6Z4EgebP6JVbHaLWaRK6lWVl5rNK43AH+MjDzhYcM1uRXk?=
 =?us-ascii?Q?Q1VwT622sq4t1AX7IZCnQ/CbPoIyxVnrwEQIlqUBXHq6M9QwrRYznnBAuJxK?=
 =?us-ascii?Q?j4j/8XCJBiEknVDV6uICV4Ua1VdPdsYHvJ/ATl8UYNAmFUury3LdiFXXCZsJ?=
 =?us-ascii?Q?g/eqiWN22AXIlBfswtQ8kTXZlda6Jr5YStcuLpBxW+FuYuGJHhtku41GQUMI?=
 =?us-ascii?Q?8JChiWNcEVcwzu+8RM4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04adf69c-1a91-47ad-2313-08db3f67ac5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 17:17:50.8896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1n+HfJvNZcUhuYD7tFQmO9sq5+EwOgPoeugqXoedOs98oiZLVu2dNbEUWucLpJs4REwDZBST22vOYkQJitIvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5420
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

> int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lap=
ic_id)

I'm a bit puzzled why this function has "smca" in the name. I think it is c=
alled
unconditionally on Intel as well as AMD systems ... and looks like it will =
do useful
things if Intel someday has a hybrid server that reports APEI errors (maybe=
 it is
already useful on hybrid clients?).

Otherwise this look looks fine.

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
