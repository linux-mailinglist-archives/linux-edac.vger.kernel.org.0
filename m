Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF38742A80
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jun 2023 18:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjF2QUw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Jun 2023 12:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjF2QUv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Jun 2023 12:20:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F91CF;
        Thu, 29 Jun 2023 09:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688055650; x=1719591650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cJQU0917xLp+RCNTPFDqpGs7fUGgCZTHYycWLwPBsqE=;
  b=Y/BAkUXlrJcMXgpOJS5IB9bhukdremgNMVRLm8r8O1O7eHPJC8ETCLOv
   VeEc/jQQNzSwRANxRPF2G9G4Us/8fScRCbZKu0CmuFJn0cRzhjCZBat73
   z9LWLPfd/cOoxkZXll+d2+lg283PjK+j7seM1qYwVaipqKPkuneLcw/du
   gBFLJGgm71xpgVDXCOMYnCzuD5Ri6J+uuZMIRLU4xZFbhphmYtkvHrCdL
   Lv8MbJFGHUvEOJOvawarkQqTMszFr60dgwpxoYoQ0X7nw+z59yg42psOt
   Njq3PCsSxErL6dSbkAgpqJbPF2bGRrIDdpefV/3ZlXuwfQ0tvEjapxuKS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="364726665"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="364726665"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 09:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="747087623"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="747087623"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 29 Jun 2023 09:12:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 09:12:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 09:12:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 09:12:00 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 09:12:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4pfifg+2PKFRk6tH2KVbXm25T8UtniyTQ1rsQGpXmePS8kk8Ob+wlhmyjICObg7VoXv5bwbxhOOWz2PgfLXpbtO0dVxNa5siHGD8FwZKBBt5tnWXxcUzbJOVUpE99inR3oXuVlHqTm+2cpK+36aTi1OhA6Uc2PqrYi8NylBEr0ud4YaV5WLUIFPBavqDWKD0jESBjqCz9GAendR23ACnSsqIjvTMRw7KQs1oGX2XdGKr5dbBKotmIk8Jj99m6Kb41u5wlV9JisTxq6s0470rO1DpKdGwnJlbkmeQBJFPtDyLNIdCFHEGw1LLdG4PPGg28DGjX8j7XUB2EyGpb1sPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJQU0917xLp+RCNTPFDqpGs7fUGgCZTHYycWLwPBsqE=;
 b=QYQ22zGPVbgFjYrrPwp5jKzZ3HWSDuihPzmZNbosDHU0hOJR29XH9MLFjm/dQfLJ0KO0aJcrJEHhEcakFIqfL0Up+2LdlReDz+kIwoheaYAsiZ/MO9efK5sW0VoEg524ZT5zqlQ0Kes3RiAs0+kCu6tqJbXoXsk3XXlPR43ZauwmdoLe0Q+S+UfQ5EQOKXxNvy09nkpwcEMe706WD/nbcwBNWqhh32JlF/PgnCxxJsgauJ4oHHuM5+MYFo6pN7XJWvzxScbDplWKZxF9ecFDRzJSGcSZR7MiAwjIIpTqVVjCxD8JxnlxgNkwKtIAFCz8Nn14W8me14uokjqVzf4uNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4736.namprd11.prod.outlook.com (2603:10b6:806:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 16:11:58 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 16:11:58 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Koba Ko <koba.ko@canonical.com>
CC:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/i10nm: shift exponent is negative
Thread-Topic: [PATCH] EDAC/i10nm: shift exponent is negative
Thread-Index: AQHZqZ42gpR/+sqH6EKfNSuXrGx/Qa+gaXxAgAC9jICAAGZbAIAAZuRQ
Date:   Thu, 29 Jun 2023 16:11:58 +0000
Message-ID: <SJ1PR11MB60838660FB93BD26F4C824A5FC25A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230628085253.1013799-1-koba.ko@canonical.com>
 <SJ1PR11MB608340E81A15F20EBAD75F08FC24A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+U7Af3ypru3O0quGTqrsJPMO3b7uoBTNjTLSixrmrvXJw@mail.gmail.com>
 <CY8PR11MB713480F6D06D11BC4742AA0E8925A@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB713480F6D06D11BC4742AA0E8925A@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4736:EE_
x-ms-office365-filtering-correlation-id: 07331c88-7663-414b-52f5-08db78bb90e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +c4gR+M/hTzt27hl3wB5lsRWKeM9cATrVfnvWh+StCacUxeVT7lWKLAFwIVS+m/dC8bex0VxGP6kvtSPeZC0N+yMBcjeIRr+iHXNsgugW0o7b71yyzM7Tk/CJdZkooxOloztTGcabN4OnpIg4BLNgaL0Bg5bvK35sULu9QdHOQZx37jS1MK/7Biq39d8Yg4ObHn24e0Mw3KLdQ6KHx9z3O6iTHtqwz/wmOhFNJI7j18obh7OXBFND/hNXkVmVJ1oHqhuHZ+zpdaDnnRGuAz4uhLyc2AUZgsWy313R4Es7xdN+jbEtAlG8oUiCDS2xPBKyLzFokQQ/4srTWWG0LvDatzDrZYEsrz85XPt+N+4D4EvQS6xFRrgMHXDriZOB6+ZTErDkDz5QrBO0lN8ql+xvVMNvYswFGK390/gYbcqMEqpf6h2/6RCOtbw9c12tnAAy6ymRERq+8uXfUKHqIqrsaKGN3YHSPYYPgmUyZod5SaBaNFEe7j87opMOBmY3x5GDz8UqMI0Feq+sHEfLqJHpLAcq++cJQRg1yRjZNh5OebJ+9Dt2mdNYRgF1OgXCesb9JoAN48GfCbW37J43BRoMWkPgBsOAS1fDRzP6J1D2oCYU3VIwKiqVYzKY4cjCvlu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(66446008)(33656002)(52536014)(38070700005)(5660300002)(64756008)(66476007)(86362001)(66556008)(41300700001)(122000001)(8676002)(8936002)(76116006)(55016003)(316002)(4326008)(38100700002)(66946007)(82960400001)(9686003)(2906002)(186003)(478600001)(6506007)(26005)(7696005)(4744005)(110136005)(71200400001)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vld3dTZKakV3NkU0RFFlUjNWQ3pxUW0xUVV3UmtiTGZPREpuQUtrakQwZ0xJ?=
 =?utf-8?B?K1U1bW5wdkl6TTZPMGx6UFlPYXpUWC9Dclg2K05kaHc3TVpvbGprSGt1bG43?=
 =?utf-8?B?STZiU0d4OElJRE5uNDRSUkc5VFJMTCt4R25vaGRXbXc0LzAvd1ZPSjJvbHpX?=
 =?utf-8?B?T2NJbURTMzdwV0czbGlpUnhRSzl4ZnlrbHJscGY1d0RLN3dFL3RiWUhvNnlF?=
 =?utf-8?B?MnhKbWZOUjhMbVhWcy9vSUdtNWRjanAyN3RKcENCWkd1UHo5aXRHQS9YMDRZ?=
 =?utf-8?B?T0dLRmkzMHRVVzlWNksyWXpnWWNhM3ZqczlWa2VqaVphSDVmazFNcXJwSEZu?=
 =?utf-8?B?c2RjMy91WWZkREpNWkpLT1BSOEVwRG9GOGo2ZGhDTWw5QmxqL1VZcDFlaWhD?=
 =?utf-8?B?VTN3Z0o1TUlZaEh6YWFHQzhnWWJTME95OVB4V3hqeGZzN0J0cGJheWFmM0Fy?=
 =?utf-8?B?YUJsVHRFenMvOUpCM1VpTGVNa1JEZE9ZUUZ0QU5EUXhpVGFUS0xrQnBLTUsy?=
 =?utf-8?B?YmNLOGpHWmpSTTNCa3lvc1FPemk2MEc5M1FRT2VMY0dTOVc1TjlYSGdZWXZE?=
 =?utf-8?B?TWZFcms1cmhVSEI0ZWhXQjQ2QVBiTm5FNUtvR1hkeXVBMTFJV28zQUpyVU9Z?=
 =?utf-8?B?RzkvMlQ4YjFKY2pSWWxsV1d0L3RTNWxaL01wdmlDVTFhcWxNMkpEZFZ4SmJz?=
 =?utf-8?B?NnVoNlgySFFPNHhmK3FPZTIwV1pneEhWdllmb0NWTjZoaDZ3T3lScmR5WEFp?=
 =?utf-8?B?Zmo3dkM3Zm1FL3o2UFJSeFNCMFBXbHNYbzRqN1RCUE5GSXVlaitkL2U4V2Ex?=
 =?utf-8?B?SXVoZTZTZmNlZExJN1F2K2tCOFkrYVZUNXd1ZmpqZGgxRzlxWU1PSjNZNDhR?=
 =?utf-8?B?ZjVjTjR6WUI2OXg0TWNBeEkxVjVxMXI4dHhXMHJ6c2RBdy9yTVJjTUlhVlUz?=
 =?utf-8?B?d0FDemhZNjYvZUFEQWtIRGpOb2ZJTk1SY3F0dmRQN0ZneWNUQ3IwN3IwV1hi?=
 =?utf-8?B?OXBjSUlCNWpORFVzbmVBTkZieWJDN05ZMTF5K092L2R4Z29qaU5UU0pGTm1l?=
 =?utf-8?B?bWJNR0IrUHF0WHFmY3FtRDVDbWtjblFrTzRWcGJ4QUtXSTd6R0NnOVBzek9w?=
 =?utf-8?B?b0FHVjlBNXRMK01VQkhsd3dUa2traGdnS1RMM0Vrb3JFSVY5SlVxZW9JbSs3?=
 =?utf-8?B?cDNFL0RGL3dnVFJrZjV0NG1HWTRpZEZIdGRpeVhoeUthbER5WG90eWFzN1BM?=
 =?utf-8?B?QzdSZlhtZkx1NlFRUnE0REFpMGE3UHlheTh3bmN6SlRPYnRPMEw4RGwvdFVY?=
 =?utf-8?B?VXRQdUliSCtKNTlaZVYrcGpqRlE2L2VzcHF4SU50U1Y2ZHBBTTFCZUxDZE5H?=
 =?utf-8?B?VkljT0RBYzRLeXh5Q3hUbmNNTlIvTjl2dDg3Ykhhb0hsMmdKdktZeGNnT0VK?=
 =?utf-8?B?SGpDZWRudFY0SXBxSlZVODl0ME55WmhkbjV3Tlh3enIyTHd4RGxvanBlRzgw?=
 =?utf-8?B?eTFBa05zUG5pcnF4VG8rMUJFZlBZUDE2d3FvajNPU3UxcHZaQ0xrTGRiRG9r?=
 =?utf-8?B?YUNXVFliNDY2VFRyR2RvTkd2dldicVdQZXVxWmZYbmZVNmNYa3pXN2I2WmNI?=
 =?utf-8?B?RUlJMDVqR01YN3c2QWZDNFpaMEF6enNCWVVGNU1zZUE4UlRmVU5yUDIyT2Jq?=
 =?utf-8?B?WUZNMnM4VWhmK1hUNjgyS1lHMlh1bVFJeGlzVEZGdjBSYkZIRjBwTms4UStp?=
 =?utf-8?B?N1BLWTY1ck9KdFAzNjJycCtGbzFFQ05lZUlHaU1ZQU0vemVJV1pJVGhnT3Fk?=
 =?utf-8?B?TGlsT1lLSUsrMmdsZi9QZTZNRFUxanpvVVNQbTJ3QWpVZGt4VlBrdlJDVWg2?=
 =?utf-8?B?eHNxZW5hbUdHQ0tScmpjUm5vZHoxZ0dFQ21Ua24yQ29Pb1NpYnRwbUxONW5l?=
 =?utf-8?B?WlpjM2VpM3J2RnZ0d3dYNFNWMW5CUk1QTlJPRGNFZWNVWHZPSld1NGZTdyt2?=
 =?utf-8?B?bnV2RlJTdTJFdS80VDNhTnIydCsxS0pkYk1qek9IcGFvaG1MTFpUTXRXN2ov?=
 =?utf-8?B?RlJYRklCS2pOcnlvZUJpU2RkUjJtNk9vOEhPR25YUFdGWm01dzJjSk82SU5a?=
 =?utf-8?Q?5eOc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07331c88-7663-414b-52f5-08db78bb90e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 16:11:58.7576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2TyNYq9D4EWCrg1Xidv8Qc5PcWKfsdVftisU4C9xWPORGiQ6nYijJaAmBZb/RpMg2JKBGjRwZPmquSQahSsgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4736
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

PiBJIGRvbid0IGFncmVlIHdpdGggc2ltcGx5IHNraXBwaW5nIG92ZXIgYSBESU1NIGV2ZW4gRURB
QyBkb2Vzbid0IGV4cGVjdCB0byBzZWUgaXQuDQo+IEFzIHRoZSBFREFDIGRyaXZlciBjYW4gc3Rp
bGwgcmVwb3J0IGVycm9ycyBmb3IgdGhpcyBESU1NIG9uY2UgdGhlcmUgYXJlIGVycm9ycyB0aGF0
IG9jY3VyIGluIHRoaXMgRElNTS4NCj4NCj4gQXMgcGVyIFRvbnkncyBzdWdnZXN0aW9uLCBjb3Vs
ZCB5b3UgdGVzdCB5b3VyIGtlcm5lbCB3aXRoIENPTkZJR19FREFDX0RFQlVHPXkgYW5kIHNlZSB0
aGUgcmVzdWx0Pw0KPg0KPiBATHVjaywgVG9ueSwgUGVyaGFwcyB3ZSBtYXkgdHVybiB0aGUgZGVi
dWcgcHJpbnQNCj4NCj4gICAgICAgIGVkYWNfZGJnKDIsICJiYWQgJXMgPSAlZCAocmF3PTB4JXgp
XG4iLCBuYW1lLCB2YWwsIHJlZyk7DQo+DQo+IHRvIGFuIGVycm9yLXByaW50IGV4cGxpY2l0bHkN
Cj4NCj4gICAgICBza3hfcHJpbnRrKEtFUk5fRVJSLCAiYmFkICVzID0gJWQgKHJhdz0weCV4KVxu
IiwgbmFtZSwgdmFsLCByZWcpOw0KPg0KPiBMZXQgdGhlIHVzZXIgaGF2ZSB0aGUgY2hhbmNlIHRv
IG5vdGljZSB0aGVyZSBpcyBhIERJTU0gdGhhdCBFREFDIGRvZXNuJ3QgZXhwZWN0IHRvIHNlZS4N
Cg0KV2UgbmVlZCBib3RoLiBDaGFuZ2luZyB0aGF0IGRlYnVnIG1lc3NhZ2UgdG8gYSByZWFsIGVy
cm9yIG1lc3NhZ2Ugd2lsbCBsZXQgdGhlIHVzZXINCmtub3cgdGhhdCBFREFDIGRvZXNuJ3QgcmVj
b2duaXplIHRoaXMgRElNTSAoYW5kIHdpbGwgcHJvdmlkZSB0aGUgaW5mb3JtYXRpb24gZm9yIHlv
dQ0Kb3IgbWUgdG8gZml4IHRoZSBkcml2ZXIpLg0KDQpCdXQgd2UgYWxzbyBuZWVkIEtvJ3MgZml4
IC0gYmVjYXVzZSBpdCBtYWtlcyBubyBzZW5zZSB0byBqdXN0IHVzZSB0aGF0IG5lZ2F0aXZlIHNo
aWZ0DQphbmQgcHJldGVuZCB0aGF0IEVEQUMga25vd3MgaG93IHRvIGhhbmRsZSB0aGlzIERJTU0u
DQoNCi1Ub255DQo=
