Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F772747BFA
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jul 2023 06:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjGEEId (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Jul 2023 00:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEEIc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Jul 2023 00:08:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E59410F2;
        Tue,  4 Jul 2023 21:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688530111; x=1720066111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0GOOABgCalm2FVV0E4fS7h8WEvsQix3VwFZvVh/8rRU=;
  b=e0NjUhg+44rD+0M29xcHM8DEnYbbF+bit+fl9cSG4gJWMRGZfWov3d+A
   6gUT8KUVm7I1XBNeOloEjphfv+PjQLyvZozjvg4JVuRUlAjb/aV/43+OB
   kQQ/Km9So3yzwudu66EXy9Qpf3U6QGnbJCAccl8Fh+Gyy0MH6wlyFlJkB
   of0GK0KeNlUU5XDqTwOKzI1ntp3G2ytZy4LvQ0JBbDBRqeYQPvz5K1e0i
   lGq8NW2bn/Sh3IvSLEq3vjgBZ+/qjJ8jGsqlFysb6LyON3lWb6USwGalE
   zZddSJtOOndkbM0FFRN1Ydyb4uERZtVLz70LIovfc7vJrPBx1PmrHkKxI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="429279156"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="429279156"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 21:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="713049703"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="713049703"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 04 Jul 2023 21:08:08 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 21:08:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 21:08:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 21:08:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dd6iiSxFv3D+KmVIfOiBWkJU49PoMe2kHsTCC+poOVBfyyoHJpA382xl6az1Yip09AgSc3ShoFjKTqsPu6axCnPb27XsGuqZ3bp0ZTO6I/B1ka7Pw7htxZEf3njdeenY7Hx9k2hXVRWkx9vowu3J3jmP+7tGq4Tvo3QIKQr9M0Yk8jGf0Pnni+WyK+WfiIAfTdQohnDaJHptMXLeraW0RsZ81et7u1RKcl4Xb/uQ+Y9+aqQhDK6VznMbGSGdPgWl+Y0TTQLggGM41dPHA1FgNYDE7ZtgDkxm8xkPuc650tn/5rwCCXiAReogZ2WtJX+m5C1et+YNChcrVpkV35b/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GOOABgCalm2FVV0E4fS7h8WEvsQix3VwFZvVh/8rRU=;
 b=nGheYtYJHfjQLWRkCyx8lA20W7IqQS5OG7Y07r6auZdc9NVFTJ8aCLwWLW1BmoSJwHCnPFAE0By37ziHc2OfMNFzM1CSiEpFs2+NQo3YW6YE+47qp9xMr9rwgjenaN/ZngeczSsLIm3EMGsCOnfFPbmz5oUMzCaekZNjMAzv0hwV26qbTgjTipxmdXpNusvz0H4F4eJVuUcrU33U6a7AlYCK+CSVaFEigZq3ctm1FXx5cBwgpDh+8Fg5UBThMglc0cN0/WbJqrIRIw8NaNDFlxGcO56y7upjBBnv/AhtODa7KN1ybTmWnMVviXo4bVxKtGJExQyOQlLRADmFht5Caw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8708.namprd11.prod.outlook.com (2603:10b6:610:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 04:08:06 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 04:08:05 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Koba Ko <koba.ko@canonical.com>
CC:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] EDAC/i10nm: shift exponent is negative
Thread-Topic: [PATCH v2] EDAC/i10nm: shift exponent is negative
Thread-Index: AQHZrc6A28+shQPK+kOOa0lv+6OuYK+ojzaQgABJA4CAAbbtUA==
Date:   Wed, 5 Jul 2023 04:08:05 +0000
Message-ID: <SJ1PR11MB608383A5841E4AE8D3A64B79FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230703162509.77828-1-koba.ko@canonical.com>
 <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com>
In-Reply-To: <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8708:EE_
x-ms-office365-filtering-correlation-id: ee673595-edab-4e51-779c-08db7d0d6f19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t33CRlRAwOKyA6mwo1FD54rSs0jfoiJJspycCz7I7LboQN4BtMzzt6VofK/c2ZHccVHBYQCf20j4LkCN2BtLSEdxiER6Z87ATcoe3LVzIlXepuxgeZL4XM47byaDH9HFUbENCMX/kbBXc4KpFwGC9gsj3eJ+jXpO9AIj7h+48vY4QqUO+yI7ghDS6ekdj+dHeNx6pRxqAnNidwcx6ibaFlJVzUq8lfFaFEx6bDsX3H0vVKHLB74CANT5weldERCY9LXemeWyvejvIFKP7JbHyTfvj9zcI1A5TLjDswTTYZJ0B0mPofwaFnZDT5fwusW3EgVzp5MjDlY5HSbB2L8psQ+8oACnvF1cnfmS/tvQzpjEtZQSHK56OfPwahrVc/Ds28yZdsW8d5Nx4ai2CPQJarTqimMPjIBFWddXhULFiEB9j0ko6oH/0v9u7xaCXUxlwXqGpsysWNp2is5MuuHALHhmMxpD361FLl03OdM1BDgtBcHS4bAGplKopH+sf+/22/YGf1lNOKLvc9eA2E8OxtZl5YA/9mDaLQCBvLfqUkxGTKvWPKqbV9lcdtqXLJ+xYr31DM2VVRt5b9n7wxc90fs0T4LnJ64XiaBHxLSR+1o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(71200400001)(316002)(2906002)(966005)(86362001)(7696005)(55016003)(76116006)(6916009)(64756008)(66446008)(4326008)(66556008)(478600001)(66476007)(66946007)(33656002)(82960400001)(122000001)(54906003)(5660300002)(38100700002)(52536014)(8676002)(8936002)(5930299015)(186003)(4744005)(9686003)(6506007)(38070700005)(26005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnhmZjZwaTJvTnRmTEZIY085MHd6NVI4SmVaZzkxbmJmT3c4VEdkdFI5QVdr?=
 =?utf-8?B?VGs5OGNWTjI4RmxPUnVFemtFVGV4eEZuc3hvT2wremF5VFA0bGJTdTNUL3dh?=
 =?utf-8?B?LzhZSTBnQzVnZEV4UzMwYkpNeFNLODBob2lycDEwbVUvK1MxUk9VUFNvcFZY?=
 =?utf-8?B?L0lnSExyYWROSS90N29uRVJ6ZDFMYXJEeWZXZ2ZqY2dybkJYK3ZMakRPR2Nu?=
 =?utf-8?B?ZG9MdVJGVXZKM3dVazA4Q0FhNUpIUUlVSWlpNC9NNkl1RE9YdjhYL2h6UW5V?=
 =?utf-8?B?Y0NyY1J3NXJHbDZ3NWpQZUJUMWdIK3F2UE1FWHEya24zYkZWc2dMWEhpYmkr?=
 =?utf-8?B?dTljMkxmd2Z4WXA3STE1VXVhNmQ4SVowMmE0eVpRaUxiWjBHcFBudnhwRGN5?=
 =?utf-8?B?Z3RyUjY4d3ptQkhHWlhZQkQvWHM2ckJ0VWpPNkVoSFhNcm1LNmVadUhsVS83?=
 =?utf-8?B?d0NQS3hvNTQ2T2paek1zRzl4YTBEVVF4Z05KK0RuOXZtZUdTY01HdUk5WnZu?=
 =?utf-8?B?SGt6d1JXcEtJc1FrTmRnc3JRZ1p1QXhOVXpaTENHdTJ5WDRqS3BoNVNHV0s3?=
 =?utf-8?B?d0EzNUlrdEx0RVppVkQ5b3ozaFlDZXZGL3ZyeGYwU3lGbTI4ZkRyZjJUNzFX?=
 =?utf-8?B?WHdKRzcrS1ZRWVU1MFNWeUN6K2xGcUNEVGFNQ3czUXBrblJRODhHTHlUQnFX?=
 =?utf-8?B?dlc1QTI3ZWtqWndmMDExOFQ0S2R6VnNTVXNmRzQxLzhYQkV2OTlvcDEybDRu?=
 =?utf-8?B?Y0piaWsxSjhydXZrM3Zhb2JiYVljcDdaOE9tOHJSUVdianhTbDVrY1paWlhQ?=
 =?utf-8?B?TmtRdW84blZjY0NFRWJhcTNwUjF5THJsYzFDMTMxSGZTakk5Rk02S2JGaC9Q?=
 =?utf-8?B?VUgzMUIySjBnUWN3MWg2RkphN3luV3ZkeEdNSE1WRVBIdDBOcHBwMXJ5YWpv?=
 =?utf-8?B?Skd2VzJZV1BqM1B2ZWhMNjZCb3JmNGZWdWdNOU1CajNiM3VOWGwyaUcyUmgv?=
 =?utf-8?B?Y1gzNTd6M21DQ2RjVUh0M0YwZE5NMkVRNG5nMmtrOEdNUUxlR09nWXN3cW5h?=
 =?utf-8?B?ZWwxd2tnNmE1blNFTHpVOTJCcDVxQXZmak45MWNzN1NzdWt6RDdlUzY2NXND?=
 =?utf-8?B?NVM3Y2o4dFFndFI4aklTTDhPNmpZTDN1WXJDK1dyb2ExSC9YTTREa1JidkND?=
 =?utf-8?B?UDB3Z3U4Q2NGSjFSOGZHNmlROVMyNDlRUDdPbWNteXRNTk1hTXZHTkQ5cGVn?=
 =?utf-8?B?N1ZpV3owOVlIUkt6WEhsWGkwcWRaVmlVLzNaRUMyVDIwcFNuczBFNnJOaUZ2?=
 =?utf-8?B?WVdZcm1obWxPNFJxTld6NEx3RnFqRC90aDY0cXNQdExTOUlwMDloeHV5VUFQ?=
 =?utf-8?B?c2QvY1Fpa2Y0bEoyWDFkNnNBTERtbFNiUzJyV09ZV1E3NjhWclVKSng0bW14?=
 =?utf-8?B?QlExQ1hNU0d1QVNKTWdrQlRZb1g3V2FMRUtSZWw0b1lOTHNyMlVDcE85MnA2?=
 =?utf-8?B?K3JWMFQwUjRwQVVVME9IbU5ZVnZmTWE1NFRQSW10M01xUDBFbTF1UGt0RDAv?=
 =?utf-8?B?RGJZN2RRRzFQeHR6MFpsSnpjcC9xTGNHcmRpaXppQXBjRXZ1YVVZMzI4YWJ1?=
 =?utf-8?B?dmVJM2RhV05BbmhBdS9PeWlWZitnVGZJNVd1SmxYdE9iNjRRMVV4TXZMVUJi?=
 =?utf-8?B?V0g3QXdwdHBva2krd1ovd1hFZFgydXk2N3hTbDNHNG5FQkhaTmljVmU2Mzg1?=
 =?utf-8?B?SVZBUEdLK0x4R0pxQ3VLK2JuM1FCWnI4dUt3U3Z0bzFPM2RxZmdFczVKNUtK?=
 =?utf-8?B?Rm9sT3RCZjdrNGc0ZUprbFNTRnhpTDJpRjlaT1FhYTA5VnRaaUREZzVSQmNa?=
 =?utf-8?B?cDNVMFN4ZTZlc2UwQ3B0NnMvVW9udFhmckxaOCt4MGhPMHVuSkNDQTQwT0lC?=
 =?utf-8?B?YTE1bWYxSlltUmViTVBCL0ptYmc0d1hFRnhLSnpLNFZpT1FNWGZGTE44SFNv?=
 =?utf-8?B?WGNMS24xSndZNzZHckZheDM5KzgwN29PMDlETlhkVnhFRWgvelE0a3Z4TndH?=
 =?utf-8?B?eERFNGFrYlF0Ryswa3JJRzA2U2hWZy9pOTlFaktZU3FGY1RlcVRyb21mVEFm?=
 =?utf-8?Q?rCEo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee673595-edab-4e51-779c-08db7d0d6f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 04:08:05.4860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUvjVA0kRDQlyHEeEphoLx/0B6vKTKpv4V5daZ9aqsNnmgwF9oZuBOUVQSHgSBTZRtbqoUO9QjTX4C6X/jTPgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8708
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBJIHNoYXJlZCB0aGUgd2hvbGUgZG1lc2cgdGhyb3VnaCBnLWRyaXZlLg0KPiBodHRwczovL2Ry
aXZlLmdvb2dsZS5jb20vZmlsZS9kLzFlcG5EWk5lekdpSnNLMWVUNFVOT2k4X2lnY0JTWHRpRi92
aWV3P3VzcD1zaGFyaW5nDQoNClRoZSBFREFDIGRyaXZlciB3YXMgT0sgZm9yIE1DIzAsIGJ1dCB0
aGVuIGZhaWxlZCBmb3IgdGhlIG90aGVyIG1lbW9yeSBjb250cm9sbGVycy4NCg0KQ2FuIHlvdSBz
ZW5kIHNvbWUgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCB5b3VyIHN5c3RlbS4gT3V0cHV0IGZyb20g
dGhlDQpmb2xsb3dpbmcgY29tbWFuZHM6DQoNCiMgaGVhZCAvcHJvYy9jcHVpbmZvDQoNCiMgZG1p
ZGVjb2RlIC10IDE3DQoNCiMgbHNwY2kNCg0KVGhhbmtzDQoNCi1Ub255DQo=
