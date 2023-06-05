Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2FA722FE2
	for <lists+linux-edac@lfdr.de>; Mon,  5 Jun 2023 21:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjFEThq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Jun 2023 15:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjFEThn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Jun 2023 15:37:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A49ED
        for <linux-edac@vger.kernel.org>; Mon,  5 Jun 2023 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685993862; x=1717529862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A1Bfab8t8Hn3EvFsXP+6mCaeISeLlE4Bbrh+8cBURB0=;
  b=PM3upgv3PPkPos5GfXaDv+7u/fnePWVumDhv716TrS+gY9RScEiwp+HR
   4VoUNFF7hdjkmdUWLtPlKdPWkll/HSWl//rNWVy9MHnc/bbhj5Ht0xOvR
   HukV02WEDPN2Br8jwgR76Aeuoo7GzsRPg/MQVjQclXSxbK1MHPKBOlMMh
   xx7sHUJg4Ci/0Sjmi+4Wn7jShtyxlRTqMYcxFD5H5YzH9FZnLn32B4dwT
   moLgOlr8MehVK8OHnUKLzeoZQXkc4h+IDXb3/FrMVKCYNfmyJFd5K3IO2
   PjoJGWmxK8HSo4MJuE09FYmUOi1SJzWyi3gD4PLcSmuBBtds183shjAw+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="353956303"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="353956303"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 12:37:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="708777647"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="708777647"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2023 12:37:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 12:37:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 12:37:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 12:37:40 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 12:37:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkIn23ijryXbewBHf3X9SkaXrfbqo0kCIL+Zjl5fFIgUNCTALK2O8qqbqTGiQoHTup4BDlJaEnTbFfX7IYPLcF3jZh05+VkDXVNDHFIp9UFX8oqj2O6kKEKr+4W0Xq/TCCHkWH9zoKNcXKzKcNVZ7iMdfUQmi5YFILOnm1rOZV/BUC/RglvMtDy5iDClCmmNab68+wFaLTzHo0nQRE3vxampBry6fu+apdU7L77S2ZauauZoPOMZ5doqeXhbl46wotBrogCrXOMlBUvEYPw+/ixL4OkZsrdIjAjNRiLSnQAlYu88MpFz2QXzUfKP0RWhqD0WpOT009gGQb8ZHgfGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1Bfab8t8Hn3EvFsXP+6mCaeISeLlE4Bbrh+8cBURB0=;
 b=n1yXSFK2DYa6uGReEgFfkQ/oQPcexdxZyikjlQRboiu2u0f55ZikFAZkxDOXQkazbjXbXm7FJOgF/DHrHr3esXXx3aPXRjjS6M/HKZN0ewKcBGJO8SCE9Fh1qTMv4HHisnhCOhg3wLgC6gtzpYR+P/24gtOCPndtqdO7+4RnBgWy0zx1X3wWOlem8LsJY8pQriK/AReKpgbgk9hiFJNIp87+FqK3d3ulq3k4gLIQvnxFYomJuuhQl+bdTJms28+9O7EKbcgF3PoLhNkxvhk67ju4XyNPKF8F2SMp2RGS3f1nhM1Hi6CpJPLHn5b9YzF4pn6t7sR0H2qn57ETGMQDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB6934.namprd11.prod.outlook.com (2603:10b6:303:229::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Mon, 5 Jun
 2023 19:37:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8e5a:470a:d7dd:a012]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8e5a:470a:d7dd:a012%6]) with mapi id 15.20.6455.027; Mon, 5 Jun 2023
 19:37:38 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Aristeu Rozanski <aris@ruivo.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: RE: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZhzo8HZ+8oxPq9k2uyIf0XEmMiK9ba0aAgAAjz7CAABk1AIAACA9ggAAMfoCAAALmcIAMM9WAgBL6hQCAAYhoUIAAJNkAgAABgaCAABzvAIAAAcGA
Date:   Mon, 5 Jun 2023 19:37:37 +0000
Message-ID: <SJ1PR11MB6083931EC73B264D9D4E2074FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
 <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
 <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230523141523.GL4090740@cathedrallabs.org>
 <20230604160442.GN4090740@cathedrallabs.org>
 <SJ1PR11MB60830E9036D6D0181CF9CFD4FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
 <SJ1PR11MB6083726809001C8E29D65F15FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
In-Reply-To: <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB6934:EE_
x-ms-office365-filtering-correlation-id: 4234ff0e-bf2a-4cbd-9af2-08db65fc51b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wHG26ydSgITlvGXkYFbdaECdHmxF6E5IXKdJVEmZTYwr39s19IxU38yRkP+kkcFFLEwB6UfNRC9joD5Ueg+noLD7VQlA5vkqFw/MPVJqI3Dt8zhOvzp9+LIQXuZELmCe9CZ3k5ripx2DbVHWe+d5SPQtiuEaD3LDmu+h6C5kyn+bN0pQIQy8s5wCB8WT8vySCPVBJpzsYV+vy5LvHdPX1dRpKJF7drU+/sgGneqwZuLzoa+ShDmyqtfInpdCiA2IbYMWVpOdPH+WtXjAy1rvMZAaSAGQ8QAbTFCTgQJFdadY2HdeWBtYKj4xRL5DK8JQ9DCoRq7KASvJebf20gjfrcQeRSrfN22peElYlDZp/B70vk881tqSgb5N50wTLMXKGVYgW68I7DuwHZOU/9AMeE263AUGHDf1mJ+J7ffNefDeE63Bchxqk0sLLFy5l/Xp5GR50yxXOIvU9HPlQ8k0kqsiBNejx9Phqf4iQXzeXMoWXJT87sXvwFA+KgX8VI0hD8LVzp2GR488U7YKcDqfiI9OYW3ZNNjX8J4B9FLpALvcaxIC5Clo3vdqub8Fo/2iiCBngIEhzLSq/CQJKZlhVMTifW2au1xYhf1ALzpxY24XzHL2Qa4VLGXNCTsYRpEb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(54906003)(71200400001)(478600001)(52536014)(8936002)(5660300002)(8676002)(38070700005)(558084003)(2906002)(86362001)(33656002)(4326008)(6916009)(122000001)(66446008)(66476007)(66556008)(64756008)(316002)(66946007)(55016003)(76116006)(82960400001)(6506007)(38100700002)(41300700001)(9686003)(26005)(186003)(83380400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVEzR3oxZTRGWTBmTjZLUGVNMzEzcG55VzFKU2k5bVhwWUdJUzZOc1pRaVR5?=
 =?utf-8?B?RXV2QWt0YzhpYzg3R3l4clNMRFg4bzQwV09mSDcxeVFqWXoyWjJ3SXcvL0NJ?=
 =?utf-8?B?WHBsMmMyOURkY0VDSjdoTzNxczQvdnpyMTBNYlRzUC9ubXVYaFJsRUVOMkVi?=
 =?utf-8?B?d1JzRWFlUmNIYlRRRTZ4KzNlODN3NjRFMTB1UVJ2WW00NVdVb3ZLN3RwWk1p?=
 =?utf-8?B?b3F4SkNLVXBCV0tWeXNPdWxBS1JYR1J3cVcwSXRBWFJlN0h2R1N6dFlZMmQ0?=
 =?utf-8?B?bnZiencrTUFJUysxcFhqWS81QWlwcFE2djBXK2kwSUlmdFByNEpmMDZ6dlhK?=
 =?utf-8?B?VlZGcExHc3dpcEdFdENiOVJQSVZxZERiOFdISFQ3L3ZabVBacmJsV1N0QlR1?=
 =?utf-8?B?MXBOb2JOc1N4NFFxVitMSkwvT0sxbVAvOElFdlBsVjdJbFZoL20vbmQxOGVK?=
 =?utf-8?B?SVpzaWRITDlDMEhpWE5kaGRybStodi8vbDg3Z1BibjBpa0g3bDFrVmx3WVdt?=
 =?utf-8?B?LzlJMWlmVmhjOWZwUWxkMGV5TEI0eXBvSlZnUEs1MTQwazdIa3Q5RUxZcEdB?=
 =?utf-8?B?ajZXRW5yT25hVFRtSXFEV1NEOVpreGw2VWhycEJ3U0JHcjg2RzFRdW1GMFp0?=
 =?utf-8?B?cFVKaHBJWVBabDdaTURqNWhma2NRc2VGMWtUSmQ3K2dOYVphSzhDMjdtamtB?=
 =?utf-8?B?d0RJOFZxd0dPUWk2YzRZMWJLcUsxYVhhcDJkQVBZdHRnWlZOY2dHYTZKSWpo?=
 =?utf-8?B?NkpnaHc1VnRKcXFseGlGYnJhZUE4cE1SRU0yelFvWlQrZUJETWptaEt6VDZH?=
 =?utf-8?B?UFNHYjZQTnZkeVE3VStxSDdXYVUyNE9kRitFV3UrVEU5NERGeWhuNGVQekNQ?=
 =?utf-8?B?SUFXQ1p5U0MwN2xkcW04WXhKTXQ1aVlnbUI2aTk4SDRha2FpQ2Q0Umh2aERm?=
 =?utf-8?B?cm9DSTZvQkRJdy9vR3FpK2N2bWZHU0U1cVdYYlhSZGZ3dG5TOW94K3lST1Q3?=
 =?utf-8?B?QkxTY0R5dnVsYjVyV2lpUmRXbUZja1NzenV3b285VXcxWUFGVXNRRmdVR0Fp?=
 =?utf-8?B?RG1tUVdZSW1JL0RPUDdnTklBVzNONVZLOG1JbHdNLzZTNGxyR01JT1BPaGh1?=
 =?utf-8?B?UWtkdkpiUVl3ekJtQ2x3UVVLWG5KN0dCTVBXZHV5dGlqcDRFZkJ4TnVJc2lq?=
 =?utf-8?B?byttUGxEWmQyYlY5UFhUZ0RUT2hlOFF1ZE1UU0ZmcFJuVHQ1R2RFQTFKUkVR?=
 =?utf-8?B?T3U5VDBIK2Zvdm9FaXU1dzQwdUxFWWNrNFB0NHRxU3RzckVieHpRMjQxN1Az?=
 =?utf-8?B?alN0THJnRC9iRkZtaHpZT3Uzb05VSWtiaS9tbU80VXhiT0h5YklQYmRVNkZH?=
 =?utf-8?B?Qk9KL1NSRkdLd21mQ2c5OWVrSHh4WWw0ZlV0YXRQeWdZLzRlQlVjSGtNdDVG?=
 =?utf-8?B?OFVOaUtsT0VNYSt1aVZLWHpLejBEKzF6RVZxcTFIbXl4eDdiZ2VsdjNVQnU3?=
 =?utf-8?B?MmM0K2tFcmZyUmJZNDgvZnQzek5NQ0FwWGNqbEY0YmJHcHNOZkNrTEtkVllB?=
 =?utf-8?B?QWREK0J0clRaVGxwYWpnUHJJOFBBbVpSMzVJYy9BdmRsRHNtYUFOWlAzVDBV?=
 =?utf-8?B?WHR2S2VtSUp4REN3SjBlRmtWWWI3Zml6aTBMVUZtTTdpVTg3ZXptTE1FeHV4?=
 =?utf-8?B?NkVuNWx0TXEvNTFTUlpQNGlmYWZ5a0FCcnh0ZFZOQVBMZGRGQUxaZGdJU1RX?=
 =?utf-8?B?VXZyTG01dnkxdHZTTk9ocVdFbTFHZnlWWWlZUlVnNTFkMUMyR0F1Z29XRVlJ?=
 =?utf-8?B?QVhrYUlwYm5PbGFmN3A1bStlL2xyNkhIdm9XU1NUYXdtbUNiKy9TYU5zV0RH?=
 =?utf-8?B?Zm9la0x1cU1VQWVWc1R4VW5WTHJiN3NmNW1GL0xpOXMrS0docm5UOE9sQmc2?=
 =?utf-8?B?Qyt3RkxqUm5NWDZ1WFBhUWdPVnZOZ3cxZHVBd1JvOXo2UVBDTDlLSDYzc2h3?=
 =?utf-8?B?ZCtycHRpWWQyNm1HbThSWVRyYktDM0ZBQWpya21sM1hIYkk2b0xjMmR0OVBv?=
 =?utf-8?B?WUl3UUpFb1RMVjh6bmZnQUlSTTMzYW9LSnowWlMrVTE2T3J1Sm8xeDAwN0ds?=
 =?utf-8?Q?Nl9Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4234ff0e-bf2a-4cbd-9af2-08db65fc51b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 19:37:37.9319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WA9ooimPpbrChkrbjmO3yGBt/ArnKBpq50ANO0PVyI5+3NneXVqBTVdHX6ZiKMkGZUTZOgjrF/VqWP9lr9KBxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6934
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Pj4gSG93IG11Y2ggY29kZSBkbyB5b3Ugd2FudCB0byBkdXBsaWNhdGU/DQo+DQo+IFRoZSB1c3Vh
bC4gU2VlIHVudGVzdGVkIGRpZmYgYmVsb3cuDQoNClRoYXQgbG9va3MgbGlrZSBpdCBjb3ZlcnMg
dGhlICJtY2U9Y21jaV9vZmYiIGNhc2UuIFdoYXQgYWJvdXQgdGhlIGNhc2Ugd2hlcmUNCkNNQ0kg
aXMgZGlzYWJsZWQgdGVtcG9yYXJpbHkgYmVjYXVzZSBvZiBhIHN0b3JtPw0KDQotVG9ueQ0K
