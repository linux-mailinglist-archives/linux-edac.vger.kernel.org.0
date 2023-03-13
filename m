Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03BE6B802A
	for <lists+linux-edac@lfdr.de>; Mon, 13 Mar 2023 19:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCMSPQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Mar 2023 14:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCMSPO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Mar 2023 14:15:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAA15D254;
        Mon, 13 Mar 2023 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678731313; x=1710267313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vk7h//99+6xtLiIUT2OMHoWe7+NGPgyQECZ4uPfbSyk=;
  b=ctJqKI26TX3AYo404voYQLS51colisUbEC77zbUh18LRO1Wyiu/j2+Np
   p/tMt/1lzLup4ee7oJsAL5Z49WW5XhU/x3AwQwl/aAjivDUAO+8PGcksx
   3scaQX7/nClCqEWiu5Rzrv8/rAiXTydQz3rCW4IAlgwUimoXeS1XJOP9B
   p017qpecRlXgcdadIjg2sJpBe5XKY7J90uEFhanNstXse038FlDzq4wGr
   qVVo8D/2vb/fEH+ujvIbKoLjiwnZpDnwwc+YEk4k5yerN8iJ+4myMMyWg
   5bn9LHEILjUOjXbiU1yYcOTNIGDywJ6930nVEL/gx6cj/D1EOztkx7Q/d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="335920182"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="335920182"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 11:15:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="852868181"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="852868181"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2023 11:14:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 11:14:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 11:14:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 11:14:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 11:14:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrwY3QUcl0aTp9uaYc20Gq/+k1pr38tnyZsKiUNvYK92zfi0GhbsPkUzTdj7G8CDzWdX8Z9x8aAUUThoYsO85fUQHNX431gYtI/sCmH4fC1MCNkmsVqA1+cohl5eZc8S+ym9kE6KzRPP9Zwq/maBclQ/wwK0rHn3Qbai/dG00PghX0wnIUKSxjGZ9XFkjVGreiNc7GWXT1gzpZzbrZ7SmzfFK5riBnBZfEROH1ND/EVUO6OULSEO6gksUpBHqZ55BwhKHs3EgnQ7uTb4VBYxvQLrrbg2A4JuoFkmR7+wTdGDsoQh0jbW+rRNj53eWIjRxvVcSLChq2TAmPnyyRALLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk7h//99+6xtLiIUT2OMHoWe7+NGPgyQECZ4uPfbSyk=;
 b=oHwtpVGy1GQ4E34iocfI1frroqC24Hqq6WH/a9yswK3IsgUyUIY2IGY64b0MNVmx+Hix+4ZmvPyTm76y7RQ8rWLUrQWB/lD0jo4rUD8hkG/9IoA4OZtXgWvEKmSged6gSnHmeKiBewAT+UX5PBGv4aMagBCfgb6iSG4PdnGr+FOCGFnyFJpVRWh/QxAiO0Y/nSN8OMI2t79iUH++YoAcX7w6Q1IwilHb382aIfdmULo7S2w3rj8u1Fk7IHxnV7PmbnX8j2CLghBIUIQQWwvBeN72rk5nZWoK+HoVm/RpGcqNSRD4CEqSyAGBSMzloTCb7n2WEblVjLnAesnozEtkmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7920.namprd11.prod.outlook.com (2603:10b6:208:3fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 18:14:12 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 18:14:12 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@redhat.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Xu, Feng F" <feng.f.xu@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] EDAC/skx: Fix overflows on the DRAM row address
 mapping arrays
Thread-Topic: [PATCH v2 1/1] EDAC/skx: Fix overflows on the DRAM row address
 mapping arrays
Thread-Index: AQHZPba5S/dNBvIlPkKlTpOjG4MtAK75LI5Q
Date:   Mon, 13 Mar 2023 18:14:12 +0000
Message-ID: <SJ1PR11MB60836A58BB3131EE480A4ACDFCB99@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <IA1PR11MB61710A47690BD5DA2826F29389DF9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <20230211011728.71764-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20230211011728.71764-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7920:EE_
x-ms-office365-filtering-correlation-id: 60bfa63c-5a16-4cc5-c6c6-08db23eebf41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qwsyCgYLBpsFnJcQiAniyBl4QwasJbV4i3WoYq8Vi9poRLGORJVnjJICVADPwNUodCA9jvLiVYaAIPusZ9esXucsQgYxuanUk5YrS+fhqUzgJrKi7B+xrVE3lVoS7K6SHrlCadx691hf44UboXp0Rs9phY2m6ecqkaqJ3MpnkA2HM0ZwrlZQ/p9bX6hWhA4uYkRBr+9A8Kxe4OQPNtRImZzQceqWJy3XuqdVpMYHQ9qXka/umGDn5j4dy0jQ/ZvqaDwAsUBeZiu1laUu0lqSM5HTljxO6RBchf7HfGd5zrsQi62+6+bLZbfHcvqKsULlzpiN1C/KyOuWmIpjQmNv8QAMUj78PjPyfkzu9X6td3oGCRp1jFw+0ilHwEARu8g7h9UrXR+n3y4C0xuYTkEseGCdzt2+tBSHeORM/UB5ClXw2VEo1pFmZuI7IxEDgMSZReF6OA9Jf3d+x6qm6f1lYiO33L179FppFytjgeYrxDVnBEahxMrOrKJ68Sf8tkQ/1xeFyA95FsdckSL6dhrCillOIautzDA6D1u9RKMaS/uDzLPDKJFsEwXcwEWYqzgNtD9geKNxwnNbCGTc79+fDu4mCnAiiKa2Sysg3tm6P8Ko4HIvzFtbqdXERt2mvShyGEESFLPUr45ckt3b/yeM03vcQ+Laiozp69s4/QEXr4+0PGJt0G7FXXJGfQJmW2w05GL/wU23ynlWGzZwmMpMNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199018)(2906002)(122000001)(82960400001)(5660300002)(8936002)(64756008)(52536014)(33656002)(558084003)(66946007)(55016003)(66556008)(8676002)(76116006)(66446008)(41300700001)(6862004)(38070700005)(4326008)(66476007)(316002)(38100700002)(54906003)(86362001)(6636002)(478600001)(9686003)(186003)(26005)(71200400001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9aj9dFnnrazEhgJwlIF+TxACoD+o4ShjFI3a0EwIu6GbO6+hDR3wXdVoqCZE?=
 =?us-ascii?Q?mEVp4ztDywfzu/B8JSMgC5xNTUkAxN3NaIU6yT037rxhaH5w8XbTNArQhF+y?=
 =?us-ascii?Q?4bhVK8sJKTJfRhD1Eo9WwR5Vyd0Znpe2tM61ePq4C2djzQzhv8jbXs5rq7ss?=
 =?us-ascii?Q?u05jBQpnGQLDEt5rrJmNrDGZxh3IdAOb06/7fZMWFqPSDc9hYUYWb9jKlwSY?=
 =?us-ascii?Q?E53T1C9sV9xw/ej8xpcLiDR2GFmHdcPAkHnsuhaYs43taRDrC+9tB+EmTOD9?=
 =?us-ascii?Q?dqsxz0thiD6IaKLPESVses/fZsYTs+Txp0mq4NJ85zxTYvY3W8sfhbRtLmf5?=
 =?us-ascii?Q?RXSYpuEbtnzVgsRP9XqGd9XWMIbLWzM6HR0VfbgQCPNL6wRiIwvhlLFfz0LQ?=
 =?us-ascii?Q?o6zS6Gyz7+YE0XqidUbduuiKtbINXRXe7Au74vHyjTsLfimtbGRVoRcpe9hg?=
 =?us-ascii?Q?R4ktiFmM2SavV1pXhNJ6dHbMPXs0uTcPxHvSuIOpZnfoKz1cC4neM6YrAEsb?=
 =?us-ascii?Q?TWHS8qVH8hhKvA9l4aujmj/lMmR8bBeSXAK+IswjcBmUhCWvuts1NgpDN7PB?=
 =?us-ascii?Q?HKrsaYeiHr0uOvtkzYHo5HZcTbq+QWgHhgnNLSF2xHPJ9eHqW3a3K651cmQH?=
 =?us-ascii?Q?mVlT1/J9Umv6uLtKx78bwwoCN5BvE7YCdwF/dqNNkEGIepTZdhnBWgkolfIF?=
 =?us-ascii?Q?GEmu06pdembbN7ehecBLxQUmyXPVqa9RiWN00bZ+wygnBgx+/+ECv8KecEDk?=
 =?us-ascii?Q?wRrX1BU54u6a/5V+nBopE5P8bgNTnlBtttby/h+pmGGQCqvDma1XH92jY3ho?=
 =?us-ascii?Q?BfpC2BIcpji3mr6eSuNu1h6vv5sXPtAlO7Yj2gwiBBY+u/Qt1wW2IIHSiJHn?=
 =?us-ascii?Q?pYiO28Gw29iLZglb4Gy1TIjHTFu5UFOWsdQOoB/hnhvPtWdH60ClO3HzMePQ?=
 =?us-ascii?Q?2+G26fl/Ax/q3vACrFFBsymJkW1YR92sQ77TYU0unioQxexAg5ENL3gVzuJX?=
 =?us-ascii?Q?qgJxXXiTxs1rQM994lxW1M+cUd1l3VNFEFJsqYeagLDzwf8gPj2eVOADvDRp?=
 =?us-ascii?Q?FACdPsRxWnbKc0CfR2CGSsoPTvjbgcr1JD8lMLiV/CpiDKPnJh08P7HpJp36?=
 =?us-ascii?Q?IndJWM3NengTTQ8xJsAGicuwWEYSkqaUugTDU9notzaOSournjyzWR2wPU1S?=
 =?us-ascii?Q?xhpHmvn08opWQT0szwCHbrcFpNHPL/ufVMbpoo4GCOeI042OcA94mjWqzoox?=
 =?us-ascii?Q?PnQRdxYSmyV1aW5qVqMmlfmPz0Nb0i1c7xI0Pu6RGLC5iSa+o5kpQSxYoAMC?=
 =?us-ascii?Q?3S5q08WuHpAVbtN+Rmxqx0GcS96B+JPFkN83ebsP/vfwyUKd0W5neFC/xqgl?=
 =?us-ascii?Q?GMqSupmeFTvk7DXAF5JPHA7A3OjKE4CBm6JuACTrPgfjExaBbz3UO6N4qdwm?=
 =?us-ascii?Q?y7SQkl6ahUONz3EPzIKYBH3V+9w9BUKgXbFBbRU7lAi8HppXKF7g/uIfOagX?=
 =?us-ascii?Q?wTQ54ihIcFVV5kekywkfKqN0MLU83tFk0RuB9ymGO8BrlmXvgC0nbUiDnhC7?=
 =?us-ascii?Q?Lr0EshmJmH3Hd4CtQJM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bfa63c-5a16-4cc5-c6c6-08db23eebf41
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 18:14:12.0692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rzaDXyjVR8ozlmK/jU7rL8i3wECiYaP3r8lGscATy81kXtUtIhomTM9Xujfa3tv762xmuIFW4pkyqx9h9fPrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7920
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> For a 32G rank, the most significant DRAM row address bit (the
> bit17) is mapped from the bit34 of the rank address. Add this new
> mapping item to both arrays to fix the overflow issue.

Applied to edac-drivers branch of the RAS tree.

Thanks

-Tony
