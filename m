Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF21E7205A3
	for <lists+linux-edac@lfdr.de>; Fri,  2 Jun 2023 17:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjFBPN0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Jun 2023 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbjFBPNU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 2 Jun 2023 11:13:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4113FE44;
        Fri,  2 Jun 2023 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685718770; x=1717254770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t/EXK4wDdvuylKuM6H/0jWEE4n30WK9ldQcPvlK3r2E=;
  b=l1Qe6O888W9VlZq2fjTPvMNedU+Ppnx4BVNrolZNbMzrddJZezKUTXJl
   26ibj6rSEGloyb+qS/e21tGien2TPltH5jyh901MWUVt63dUrLrrIUblJ
   U7bJewy+YkbnbF3wpNXu02r3d7scb1D/E19yfCH5YJKUx/kFlhuCq/GF1
   B1k7jsqQdC93YFxtu4wy40xy5fyfpzVPTQVVe1SwVkKNTmlWHvHV7FwXj
   FreaU898BYM5bIyMYZgvIWjn54dUhmTE0Ph0nFUByswRJK+Sfp7vcE/WW
   ZQQETASOvG3QX1RHTE4keit2LK1+bN0dkJnvwahv5V+BUudlG73iiYU81
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="336255291"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="336255291"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 08:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="954535606"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="954535606"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jun 2023 08:12:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 08:12:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 08:12:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 08:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW2m0SqQMeA3cwd7tkolLKSUCqplesHc1t+HGFcQlUztQ3ujlbNAEg/KQkOPr8FTaG+vVj7/anflwisAXPXVc0b8fOVDgv9CTlDizyexZfdtwkx1HlycOzqwDxROSOez6os5FTgBgs287IyQZplKWqPNX2BvisrTKdusef7oaeVwb59E1P6GzhE1x7qmay7iXOMwQGrbJ9Wi/pnEqMh6+MdZpnq31/x6ORCpEy6AgW9kPn1kz1x0v85MReenQOqsBzksZjKmmUY257bGJSzZXm2eM9kKrOCullphG3Ftclsz1gIuoFOEoUisLRbUH1rDbZeZdsGIcB9//Gp6oZBX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/EXK4wDdvuylKuM6H/0jWEE4n30WK9ldQcPvlK3r2E=;
 b=KDj6lb7JqdwM11TLtsJar0mPIFFOw2G8tipQwEb4c1aXxiBYBAU+gSoJIhWz0xC3Cmq+fUMTgvRFG/iw1fH2wd1EdskhH0tzCf1vy8ht9zjbcdlW91fcMGmkK89/NvX1Nk7whrSHpNGqDT/vUtNVnw8IbO8osHb2M2ROeb+nB6ffF+QxsVN+rYVg+0ke+dJuAs40i7/MAYqt6xMJBLZ3CqjzoU/S2FNKWPKJ4K8t8mzu0vlLAS/3yJ6zVaZ1QuD9ZtCTFSBYgtZE71kEUh9NknBi1HXtYn5B+Fpnk5x/UPED2FhrDbPbEkxydM1bTe63NS7U8QqzSiRdC8an8+tWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ2PR11MB7502.namprd11.prod.outlook.com (2603:10b6:a03:4d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 15:12:31 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8e5a:470a:d7dd:a012]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8e5a:470a:d7dd:a012%6]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 15:12:31 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Borislav Petkov <bp@alien8.de>,
        "Song, Youquan" <youquan.song@intel.com>
CC:     "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "chu, jane" <jane.chu@oracle.com>
Subject: RE: [PATCH v2] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Thread-Topic: [PATCH v2] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe
 Copy
Thread-Index: AQHZj5mrPZ8KgkI/kES5wuCU3feaCq9sIu4AgABWIoCACk9kAIAA4LBg
Date:   Fri, 2 Jun 2023 15:12:30 +0000
Message-ID: <SJ1PR11MB6083343FF74CAB54FC2B916AFC4EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230526063242.133656-1-wangkefeng.wang@huawei.com>
 <20230526070952.GAZHBbQNAWZJP6tOXv@nazgul.local>
 <e816734d-e6f5-b990-c86d-ac7d5f1c94c0@huawei.com>
 <fa272c15-9f7c-df9c-41dd-bffc19acbf85@huawei.com>
In-Reply-To: <fa272c15-9f7c-df9c-41dd-bffc19acbf85@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ2PR11MB7502:EE_
x-ms-office365-filtering-correlation-id: 9315b6fd-9fc9-4eb6-4809-08db637bc926
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AaaxuYsDIpSfWkmABipmJ73MInnlr7hjqR4h49/JdYoUxuL+uHJaeMd/pRQjDcWxEGvp+AxQ8yhYBOdrYMEOS5IBaYjMA6+asM9P/2EIFm/k11xZop98V606JkzJ00mfoJ7la7l7coKAR8jzv3lkwrRSOsZ7MVFSsmzGPX+fTRtsb20wgn8zCRogvNlT3M2EVfTxr0NlvvkNL3pzmF/xcl4uI5x6PpMmeCh6YW9R3RoiKHutIGvmiZcJb55HueUzScsRLzf3pFTecgfmx8/TyRQTltCMgU4sHWq1HCSTSoJwHpHPnKQXTHaYu0619qrKmGPpEmTGNdwXwHoTiWfmaLPq5Vlaqakj8jDqr+NUk+oIJwVpKuzsvfA54PLU1nzvdViZ+UbtCWvMrYhfqDLSaCfhA5jsTyxuoK3XfBiq4y0XIts0atpIjF9HiOdY4Mg62Mn+JGhDtWlW+HSv1hqYNZ1saeRGV5ka3B/KE0D2NwuQNfdpOLB17H/Hn1eUL0R6JXZJXzBdrB3g8s4KFmBypDcJF3Fu+5PQ5J1ADsTxDAfcEDFERxkJhd0898pZb8teY59R9X9Z7wiX6Vog+Jofy3wQ0DTbx7tvxcLgjepLhAv3oi085M6RtGlSJKZOzpEMBMptP+TQxx0evKbnT+RRnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199021)(4744005)(86362001)(83380400001)(2906002)(38070700005)(33656002)(122000001)(38100700002)(82960400001)(55016003)(54906003)(26005)(7696005)(316002)(41300700001)(52536014)(478600001)(8676002)(8936002)(110136005)(5660300002)(4326008)(71200400001)(66946007)(6636002)(76116006)(66556008)(66476007)(64756008)(9686003)(66899021)(186003)(6506007)(66446008)(7416002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejdtbjJEaFNNZTQ0cFFEMTRaZlBBRU02SDlkYlg0bkR6VVh1RFlVeTBacHJE?=
 =?utf-8?B?RFVWYzNaRWxaRnpiS1dLU1ErN0hTMzY5ZGJodWZkOHA4SVFsNmxQYXVmUXJs?=
 =?utf-8?B?VXBob0Z0RU40djZTMzFDK3VNVEkzWkphQVl0cDhncW96Z1ZodXdrc01UTmxw?=
 =?utf-8?B?U1hIV3h2Vmx5WGY0RkxFdzhqQVR4cDJyc3FlV0F2YURleDJyc0xxcS9TYXhQ?=
 =?utf-8?B?aU91RE1wMStlZVlTNWN1clhwTmxXOG5Fanl0ai91L1dEMURvcXV5a0VhRGlC?=
 =?utf-8?B?eHgzN2gxSWdZcTh0bTV1cEVRKzRPZmNhTkhaWmpSV2NpMCtaTi9YK0J6bDFQ?=
 =?utf-8?B?T28ydFRsVGRhdjVKNDR5TzVpRDZjVDNuUXc2ZklGMzNKVjBySkNrbjF3YUlD?=
 =?utf-8?B?dXJGdzdzSWhrNjZUY1dPNnpmRzZnV3VhUUMwelcvRWtoU2FLYTZHU2FIL3F1?=
 =?utf-8?B?U1dBOG1BekhSSmVBaGJseUNoanZzc053T1FIcUkvOFZNbXRQYTVRVlVjVEFH?=
 =?utf-8?B?VFZxWGwvSXRpMDVmN1lWZmlHYml5UVNaaVRTTVRRYklEZ3FmSzJjZTdzQStK?=
 =?utf-8?B?VHlQRjRFOG1PallGcTBZcllzRDNWNjJ6a25qK2FrdWhrSDA1ZEF1a0lvNXFl?=
 =?utf-8?B?WWRLdENFUkRTVVpJRG5rMjRpUGdheS93RzhOSGFPZG5rVGVheEwrQXJHMzVS?=
 =?utf-8?B?Mk8vL0Jqc1BuQTFYWm9VR1lEejI5cmRLdFd5ZGZaT0tmUCs2bzFnUWxkKzg1?=
 =?utf-8?B?bW5YSnBmNkFtbFVvaWlTY1pNNUZsOXA4RHJDTmtaTGlXNEZvOWhIUkZaYmEx?=
 =?utf-8?B?SUppY3VqRUNEQ1dxeERlSUxSYjdzZjJpdlBIVDN3eHl0QVExWEtlMi9IUWM1?=
 =?utf-8?B?QWV2MFdVL1gxMzdaK2E4R1NCZlhPdGFyQ2Y0OVlLVnNBQmtVNEp0K0NGUVU3?=
 =?utf-8?B?TDVRTUMyTkZWNDBOM3lya2dKN0pSSmhGam5MV1V4VnVSa0YwTFQ4c1ZTVUhN?=
 =?utf-8?B?ckYrL1dqejNFcEowSTJQZkZCYzVESTJHOXQ0ZUROaWptbTVQc1pjZHg4cUsw?=
 =?utf-8?B?QnM3WjdiSGdPdzYxb0RUUU5qbG1Wako5bTFJcm9lKy82Z2Z5OTdXZ3VlQ3BI?=
 =?utf-8?B?NStvK2dVajFtKzhZVzhxa3AzTUt0MzdPM2E1VUJNYzRuOFF4SWhQVVplK21t?=
 =?utf-8?B?eE9JOEZVSjg2L1RZTXNhUDFTZmFMNTNFM05xbTlHbTdzbWhJeC9EOXVzclJv?=
 =?utf-8?B?ZFY4OGtRUzAyT2RxUkxpZFhITTlJdmMyekNyak1meWtrWnhWaEpDdENzN2tl?=
 =?utf-8?B?QWhmUTRjVjRRYmRxU2w4ZHhoOTVxWUcxa2k3Qm9FN092U2xuMFNJLzBUNWsy?=
 =?utf-8?B?eXJHRDl6cmRvMG1NSGdWQ01Hc1F5dFJGN1A0U1lmNWJFQVZyY2w0dSszb09x?=
 =?utf-8?B?WS96L1hldHNYeEF5OWtrQWdNc3RxL3M4ak8rOHI3aytiYWZGcW16RlM5Rlg2?=
 =?utf-8?B?NjhFMUhWMkpHWHI2OUVVbXljQ3dhWGNJOXV5Qzl6TGkvYTJhQ3dvWTVlUTV6?=
 =?utf-8?B?U1ZaR084SG40dSttYmxFcm5yN1lpZ0xpMUNEMUhQUGlLc21mRFVVcHNkNVBw?=
 =?utf-8?B?ZXR0UythSmZkbll1SjIxWEs4L0ViUHgrL3J2SjBoRit5aGluR0VhY2RWcjlq?=
 =?utf-8?B?bzdzdDg3S2xSWUhPeDV3Rk9LUklVOE5WMXk0eFQyNnRzdHBaVEdEMGUzeEVu?=
 =?utf-8?B?L3dWdXRaN2UyY1JaTnBnSTI3N1d2b3d3SjFvSTJ3Ukg3dnp3ck1mWlNUejBQ?=
 =?utf-8?B?TFE0b1VLZ2VsMmZPaXhWM2hwZFdjQzJEcUl0NHpjZEQyLy9zWm8wNUhSYVdU?=
 =?utf-8?B?UCtLdXJtZTBnUlFvWmRpbFQ2V1FGOGVnejVLOEFYNjRueUxzbG9tdkltUzVQ?=
 =?utf-8?B?RE4xZmF1R053VEhLVVZSdnY0aVcvbkhDSHRweEZIV2UySE5nSTNNeHBud1N5?=
 =?utf-8?B?cS9meFBlVDJKR2RsMUtjZVBNNDFUWVBLQWdMQzFZUTZWcEp6aU5NU0t4T3Ro?=
 =?utf-8?B?STVnb2l6L0pJUXdnbmF2UGxqTFdIQ2trMUpGSVlSMWFUcHc3d1JZSmp6T1ZW?=
 =?utf-8?Q?6ONQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9315b6fd-9fc9-4eb6-4809-08db637bc926
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 15:12:30.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kGARgcV9O8D8sn2W7ZMCZ9uOnggaSgLiE8HGGA3e41RCDF27zNyH2VVdgDXm9SxDZ8jcrlpgB0z9kJfD4yzsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7502
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

PiBBcyBtZW50aW9uZWQgYWJvdmUsIEkgYW0gZm9jdXMgb24gY29weV9tY19YWFggY2FsbGluZywg
aXQgd2lsbA0KPiBhYm9ydCBpZiB0aGUgZXhjZXB0aW9uIGZpcmVzIHdoZW4gYWNjZXNzaW5nIHRo
ZSBzb3VyY2UsIGFuZCB3ZQ0KPiB3YW50IHRvIGlzb2xhdGUgdGhlIGNvcnJ1cHRlZCBzcmMgcGFn
ZSwgbWF5YmUgd2UgY291bGQgYSBuZXcgZmxhZw0KPiB0byBpbmRpY2F0ZSB0aGlzIHNjZW5hcmlv
LCB0aGUgKkZpbmFsIEdvYWxzKiBpcyB0byBsZXQgY29yZQ0KPiBkb19tYWNoaW5lX2NoZWNrIHRv
IGRlYWwgd2l0aCB0aGUgY29ycnVwdGVkIHNyYyBwYWdlLg0KDQpBIG5ldyBmbGFnIHNlZW1zIGxp
a2UgYSBnb29kIGRpcmVjdGlvbi4gUmUtdXNpbmcgdGhlIGV4aXN0aW5nDQpNQ0VfSU5fS0VSTkVM
X0NPUFlJTiBvbmUgaGFwcGVucyB0byB3b3JrIG5vdywgYnV0DQppcyBjYXVzaW5nIGNvbmZ1c2lu
ZyBub3cgKHNpbmNlIHRoaXMgY2FzZSBpc24ndCBhIGNvcHktZnJvbS11c2VyKQ0KYW5kIG1heSBj
YXVzZSBjb2RlIG1haW50ZW5hbmNlIGlzc3VlcyBpbiB0aGUgZnV0dXJlLg0KDQotVG9ueQ0K
