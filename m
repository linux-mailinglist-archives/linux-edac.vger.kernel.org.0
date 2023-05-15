Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8614D703E9B
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 22:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbjEOU1d (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 16:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbjEOU1b (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 16:27:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E24D11B4D
        for <linux-edac@vger.kernel.org>; Mon, 15 May 2023 13:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684182448; x=1715718448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cV2qqQxyU6t8YlBw6blaRtfh+iQlYp6q7n3A4Cwf8ew=;
  b=ZvW4MdjVuta6eu2sr73NTB8YVGfjfz2ylOeS/2k5p8HcPx1xRyDX4IhT
   A01/dlc/7aFJGvUE0c0RqiuPVX+PacBRexMGMEKUY46S/l5FF0k68Knjy
   MzNXr420lDSSJ9XkUc+HVYaocX75SYj9NVVr2BzeAgjps+LkvGKUmnmDV
   QVhxoOC1+zCR4JeAsPvlDA4w0C/0q68MiYCsSEuMJ84WbIlQdwseLOoAq
   ZlDXKNddunGYrcjWWrNB4WGSg6Hc/NfpMcVxQgo+qqlUXcByZsoZ9d1ro
   dafTiiv5x7UBnrhvPd0VCBopXeHCZdzHQ5G3pbRKKpEIT8cgIYXLITiVQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="416958925"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="416958925"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 13:27:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="875344105"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="875344105"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 15 May 2023 13:27:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 13:27:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 15 May 2023 13:27:22 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 15 May 2023 13:27:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU2RLlWfgHIOO7fKH84XWCcLVeGKt+1PgyBpaYJkQrs+Awcx4KQ9dxFc28ZVZUb2bg2NAVw38QRCHfg+SP4LyjdmCzZUxF1QOzc9/1WJGse/qj1DemiFoIko/9F16ruLlBVeoa4xTEBcHSRE7JiPW9Sgko4U18zkHdspowEG+JjySe1TWSfDGewirdavyDlcqAtdZecZRkxseOFb2LdJm7mj89XDmTHDMZasQWNTaUr072KAGIiXxiqKw4H2Ejn1ba1nx3/7POtiHsJcX5dn/zMQLw5b946nn/IALQe5nMJ51KH6/JY3dq81tz4/31QIT222JIG+7dakfJueJJuHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cV2qqQxyU6t8YlBw6blaRtfh+iQlYp6q7n3A4Cwf8ew=;
 b=HNVEVbD9Y5o9v3rZ5R+KsMkoB2zeT7BbBNzaL7RPcq9dOJzClUl5tGDn1DZdul4MqGL+gCAV6ZJ27fBw5pnlSXgRjk7UZ+QinHFp4ee+DhmjjY3BSGmV7KarVVo6A/nsuQXEPD7F1NMvBudlz0V9+K7SoA9kHd6yhJ+9P49QIiGxAH6PcEguSBFuvvDmCuBu4c4YEipt4tY0umyey66sTsVZ8jtqU9u2ASTiIAwpHf9xoxmy0KzyEidR55gsdK8EKXD/jSQvjKWWkc8Ko3aEhEBNYQB0vbPuMDKc3zyKA/DbYhIfKKq0UJrs/LB2POlcrZ+0tnK/yRI3jSAxQaZsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB5428.namprd11.prod.outlook.com (2603:10b6:610:d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:27:19 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6387.029; Mon, 15 May 2023
 20:27:19 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aristeu Rozanski <aris@ruivo.org>
CC:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: RE: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZhzo8HZ+8oxPq9k2uyIf0XEmMiK9ba0aAgAAjz7CAABk1AIAACA9ggAAMfoCAAALmcIAAB1GAgAABc3A=
Date:   Mon, 15 May 2023 20:27:19 +0000
Message-ID: <SJ1PR11MB6083A169CC5FD7057338027AFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230515143225.GC4090740@cathedrallabs.org>
 <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
 <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
 <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
 <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515202057.GD4090740@cathedrallabs.org>
In-Reply-To: <20230515202057.GD4090740@cathedrallabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB5428:EE_
x-ms-office365-filtering-correlation-id: e438d611-d078-40b7-1ab5-08db5582c81f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QlKzKpwtfICplwTdJQQIzKIq7iI5BymHFIOX0qB0oM+C49m301ucoCpWdfLSiOyvmdoapFxzLfZzVFbQkqANQr2q/gDStvthLcb7hSI/ok8FggMnHwiisz3QGbmC4T/QQQ2mEG12s3BSoDrlrCpckPJENnGaNOh51B2hnxwuaBsDZtbrnZ/yLwpwgEyTmYkrSRdXA+TXqmFppvjC9bFuCfgTA3dfwGFM9Yc8fFS0t227rCu988TdZz1wYWttdZuqUfi+U7rWsVeEnFN3WTJfKTDhPwipEf8xxUDQeGQtpCJ5hsMJhvD7NQwb5MdaHJ/eaK/o1bVNpmYkbWk1TqUb6dNNESwa7y1JdfAIeXO8ltsQ6xA6fiD3Vw2jdxFvDQTVGlT2uiQEEy4e/rwuxa2crJa6aQpiZdAmov3ViR6vsmxol5SWIuKNbIRkF85GJ86KFXhpVNjgWo7PknLZMBRf8EoxUJgnSETJOBzSBZ3zXZzCdvPJXlCY6DwGbSRQjyBgXT+XvcANjfDiuIyb8TPZAYbYPJ9vSe9oj3tSyay7Gh2eyVNzc7SMA6b3gJ0e6Q8KpFI/ARNKW+O1p/yyZbL/i0KQSltYtooSbt9ehPqElHs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(66556008)(64756008)(66446008)(66476007)(4326008)(6916009)(478600001)(76116006)(66946007)(54906003)(9686003)(6506007)(186003)(38100700002)(38070700005)(8936002)(8676002)(2906002)(55016003)(71200400001)(7696005)(316002)(966005)(33656002)(82960400001)(86362001)(5660300002)(122000001)(41300700001)(4744005)(52536014)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6YAWfIuRcQaSipjB5heajPj0R1KTjxlL6obwPY1syV0a16by3k16ZGKPj222?=
 =?us-ascii?Q?2vaZ2FmvlotC9Qhaz1QCXzSYDASQIeqh2P9gqfMhkWPZhd/ZpshKDZ/H9QyD?=
 =?us-ascii?Q?4FmGFfiFhTCc0rVsyh+8KLkXMClO50X7VEb4aA9mKTTusAaPuMRV9wLtzvN7?=
 =?us-ascii?Q?/AWAbyygf3OsZ+3CZhM9tKRO/kh30l5Yo1XQBjld/OxzMqIYuV5FXBFZ0bbc?=
 =?us-ascii?Q?+VQ/aInVNjB9M0j69dgSk2GnYMM0oKCHdUZS5xlXQblJy71lKDdgzg+jSCG1?=
 =?us-ascii?Q?thj5RaQNPojdN27MBkhsmt4mjroYbQ5OW/2lmQQVv/UMI4s6MldKngozIY6O?=
 =?us-ascii?Q?0sgvy+B9AZ2rMHL7m6SeSrme/p7BIItbfad9TdF/yDNLj64GSqBZXZiwepY7?=
 =?us-ascii?Q?C7vtgrXVkXyXIWaYqq62ueRvVdir2SA8Mi6G3V6705m/AdPv7bTq5bvpqMSn?=
 =?us-ascii?Q?iSH+N6b1kIQyBnqfS5/y+634hkSw6clbPSHxWzMVIq+DzK61PZQZUuYtfEh6?=
 =?us-ascii?Q?QytebGLgU4z1bSfQ01hkcfi0HDn6MI+9Rq16sTck0jHW3Cyg0Ninwd3ebjGK?=
 =?us-ascii?Q?IiJQmLmcQFHwDdjBYHPXs3vGSeWbqu3t5Lc2Q9P3HZiG8UOzzSHg7lK+vBqm?=
 =?us-ascii?Q?cU1PWD12Oz/iaBQoPJvPNyz+UfEWAp7lTD0ykacmhHFa2JS8chF0ZKc/8pAq?=
 =?us-ascii?Q?PAn64OGMuQpsjPgrw3EqJyo8m18AcrHTw4iNBymxSpyi6R2yvtl2u0zEyvZU?=
 =?us-ascii?Q?Opc0hbIVDDqtEgCWzk/Pu5q6mwp1Hxk/Ya1rycI2+dfUQPwGn5QPjeOJ87/E?=
 =?us-ascii?Q?X02ej1vpKJHgPhunT2C4PvdT7N0J/hz7rAOMKU6rKBNXiiH1ISORy5+/m+MJ?=
 =?us-ascii?Q?yxa/RRqH3Wq9kt8Tudp9xh+KZc+niu4yyVR5DtQ/fr+Ma53qcFAq2ffsqRmp?=
 =?us-ascii?Q?rEySVEpm7U55PwzUIdrkcBpdrZ4pKSLeT8EXuZkdClfDOq875nmGRlkQJYaD?=
 =?us-ascii?Q?4cSYYv5Gfgk81Dt/VO3bEVBP8Pp2QX0DUWgm4iC96cK/yiDeM57PtuDeNsjS?=
 =?us-ascii?Q?5oL+R9EuyzTuoGTBfM/Pm7FJn003+s6nzEzgfmrWQBgVFcRC5/Ae0+DMcWSd?=
 =?us-ascii?Q?An1YLMgBt1badVFRhcrkCDv6DzzgV+LINlWIEg/YEKtbkGhWiu/CJdsoONov?=
 =?us-ascii?Q?pS7JOrhaPnm1vPZk0lvyEYZeTnjOdxVpUgyRWPcAwLMm4senRY6i3GZzLCki?=
 =?us-ascii?Q?FkVoUIHLB4Q32Yphh4w1wZnygurC/9jkO5SrPVunj+hXRowsKHOZO1HVoyLL?=
 =?us-ascii?Q?+clJYx0gpogq7bHtc0k+tT7g3EHiAuyDalFAw1MGcPO/Dflqo/LwINk4KvGn?=
 =?us-ascii?Q?P1Mpq+GM7yXQbxNJQxERAgAXML02l1EdvWj8kAPc5YEl4ufG5ppza7uKGcNp?=
 =?us-ascii?Q?PD8IkI734zg1n6U5WW/WTckf9VNF4uvBMdDtW8pXG9ZwhaKCC/dfJRdUBcGA?=
 =?us-ascii?Q?RyXAujtW09/c8GzIPGc59g6TyEVYYAVgiE/tXCiNugSs0d8hvY9LYfpBJUNG?=
 =?us-ascii?Q?nJxkz4mUpVBCAx8xJnc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e438d611-d078-40b7-1ab5-08db5582c81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 20:27:19.4587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rI7KVQdUrYq5taW+eMiVncfI1piu5Ra5gs/KIaCLu+CWLRXKwYZHCxpPfH4a6Gvxh5FZmSfnE56AZAdfA5kBPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5428
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Partner has a toggle in BIOS and reported the issue. I suspect it has to =
do
> with a big mutual customer that wants to reduce CE storms caused CPU spik=
es
> to a minimal, but I'll get more details.

If CMCI storms are their problem ... perhaps this is an answer:

https://lore.kernel.org/all/20230411173841.70491-1-tony.luck@intel.com/

-Tony
