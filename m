Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6707054EE
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjEPRZy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 13:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjEPRZx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 13:25:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E8A3A8B;
        Tue, 16 May 2023 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684257953; x=1715793953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oyGZERBXJMH/HUvn9+c8Zj8TcLh3pZUVwN2+oAx0gQ4=;
  b=RpLrjdY8v3yJmtUfN7Ep4oPBb++YznZUY4VIrZ9S4Mz+kCO5RN3WhCQ8
   W+lfxcugxWOvblfmHAk7YapfJ60IcrvkHQeY/DAhr7ZpZFUZ392BjMI9z
   3bk3o84R1GGCeXLrqedBJFU69ZqJEmVsqdwsxov97Rk6A0zFr5iK7+Sdu
   3WDLcwGGFP2lQubg1EFQpPTPrC7LgJfT85kG7sZm1UBKR2cNYW1dVfGE8
   8P+jzFgOLYd9tPWTMcbm04ANaBKNrRH/9u1lo1hQ0sNhWcRakFzTZepMj
   8lk8fOCX+Wp/gLbQjAKVVrFiMRVUoRFdDhsBvses7xArOOOQHpFxfvAl3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="379726850"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="379726850"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 10:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="875729738"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="875729738"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 16 May 2023 10:25:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 10:25:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 10:25:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 10:25:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 10:25:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGUcuBcVV+5noeVfbRV6XpcshN2EItH7ha4+pXXC2cu6l864IHL0uy5MuN+rm0I2EZ97lp0/HvpKFyGarjMVPfdp+Ii3D3Zq5xVquWy86o1FTGovk4L+oBlMiLN0G3avAUU68O/b/k0z+ANUXW6fypDPhZGHB2RFYjbtT29SJHvywcK14YeKPPXConehcwHTKxScOPvNB9ELKyCxzoAW0Ee6fHLGwwwWpvJL6DjKxTP93/AW+D/LnVpSWkqm1db5fPkKBIwhkvNf2Jzr5xJGJrVwj8OBG/lmAXkmlPueDCw0uy1vqpMJv8XGj9fR62Wl6UF1IN2sU/jtMgrR1eOsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyGZERBXJMH/HUvn9+c8Zj8TcLh3pZUVwN2+oAx0gQ4=;
 b=mQRpFQab2t4QxJ1VDubUluLS36FaxsTpZQ8Du90mrxUxwpBkr2xkYw6kAdtWkIHWGktPT9ka0NFt0HYLbCBMKv3eerqwmXp8DuYwyWJrgwBfpYZgvtaA8mLtYdQ/BbQ2W5ClKamn50I75+oEIqVchK6zgKV6bAceBG6jbW3/gH0zfUfd0VbTHjHDjSFBbuE2w4ZjN5G8rHHgdi+mNfwUIiVrkr1O7Mw+3djXdQCnCZ4ej9Zfr2IVtyQ+vpLIazLCaSyIK0HkfXtXhfXV1mYvUVZbQo1KQsTrsQB+sw5JQLjKCxkH+p9aginCu4/QxT0x61aAxq6Obf9ciWOgl+gf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB7179.namprd11.prod.outlook.com (2603:10b6:610:142::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 17:25:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6387.029; Tue, 16 May 2023
 17:25:49 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Yajun Deng <yajun.deng@linux.dev>
CC:     "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "rric@kernel.org" <rric@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH] EDAC: Expose node link in sysfs if CONFIG_NUMA
Thread-Topic: [PATCH] EDAC: Expose node link in sysfs if CONFIG_NUMA
Thread-Index: AQHZh82fSWu1eOhY9EeyDR7AGThym69ctEKAgAAJQoCAAAN/AIAACwSAgAADHwCAAFYfIA==
Date:   Tue, 16 May 2023 17:25:49 +0000
Message-ID: <SJ1PR11MB60831CF4AC4E4C23DE362E0DFC799@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230516111942.GCZGNmzu3Abd4KmZu3@fat_crate.local>
 <20230516103403.GBZGNcG7Q1sdtUpcHW@fat_crate.local>
 <20230516080748.3155788-1-yajun.deng@linux.dev>
 <e930d9a3efd6d99d2badc7bdff713afd@linux.dev>
 <3509bcc597e37616cf45247e8f92d369@linux.dev>
 <20230516121018.GDZGNyqjm9YWQp2Of4@fat_crate.local>
In-Reply-To: <20230516121018.GDZGNyqjm9YWQp2Of4@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB7179:EE_
x-ms-office365-filtering-correlation-id: a4d3720f-35c7-45a9-c865-08db56329786
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OsrL803XkS6IPLIwupuEP/UgunhMYoc0qgbyt+j4hOHfu67Nhc/PxuXUgER2kbqDiBtjkOD9SqJQZxYQR0IY2EQu/ja/sWRtyhQDGsb5IQwXzIz30CdVyRRS3R7wiQWY6xL6n+PH6DvMDNySgtkupBYt7kaySo958qTw1FQZT7goED4oiBgmI03gCgRWycHU3653i1diG0iU5vYsCTxHv/jomh+w2yGQ/B0LVbNnUL0duCmANtjn0iJYlMnHvHO0C+E6vRPQZjQSryO6Mjcf9TAULZMJJVqeHGQ+All6rR4/jWYrrfwM29J9mXn0gq1dVT/DRLKx8szg4bPGLiFtjcAQZYSU1g+890M828ju01g5PqieewJipxL0C+mXSKJ3QSywBqGTluPIfhRWbJWL1NW1qzgjtpcAVDylAzsSd6TQqM+Uy+bqtkdY5bzgWr70CDIVftiRca5GaCENXZ21maZ97EhD7Le7oNGO1J7tT383MjhVSG4jvjh05ay7+L6mVWzwm9w30v/pa2/7qXQD26lm+3/uCXAkPbsz5VFCuH7Siw3eqF8abYWR2f0eEGE2fGzsqvSKoGau/nwn5l/XCMXtVQPARem+61Fh/DZl5cObYHnINit/zvWxLfVzBENr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199021)(5660300002)(52536014)(8676002)(8936002)(186003)(26005)(6506007)(9686003)(82960400001)(122000001)(38100700002)(38070700005)(71200400001)(478600001)(7696005)(110136005)(55016003)(33656002)(66476007)(41300700001)(66556008)(66946007)(54906003)(316002)(76116006)(66446008)(64756008)(86362001)(4326008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SURJMDBvelZZeFA0QkV4Tk9OaXhPZDQxbUVqL0M2aTFLSCtHVWdidkJ6SzhQ?=
 =?utf-8?B?TjJlY0VwSWRlbHpDdXdNSm5oQUd3QjY4NmVHbFg4WHhqanltdkZCZVRaVTgy?=
 =?utf-8?B?d2hpY1dvR1NlbDR4STFYRm56U2NtRlh3YXhwZGVQVEtNd0h0TGhJZW5pQjJR?=
 =?utf-8?B?ZWgrL1V5ZHdpTUxBV3d1QzZXZSt6WEV3YllFMmVFR0hyS1pDSTlyYkNZeUY0?=
 =?utf-8?B?QS9UY0djM1U3RU1YTGs1bklNK3FuY05YYnpSeDVFaGx2YlFvZWxHL2pyZGlX?=
 =?utf-8?B?b3pJTkxQUEtRdDFWZGx6UDUvakFuMDNVMER1N1VQQ1huWllpR0g1N0YrejRh?=
 =?utf-8?B?RkR3TVVFVCtDM3NsZlFtb25vRDVvK1A4dmpYSUVNbGlDekx1eU5ZK2pyblBN?=
 =?utf-8?B?TzZleW8vVmhEL1BsZVlXQWQ4L2F4Q2Y2SE53ZUU0cG5GamNQYkdENW9GQ1cw?=
 =?utf-8?B?YW5Dckc4Zlk2VzlESGlJdXhMYmJPWUlrazNZN0d3RmViRm16VGtzUU9xWm41?=
 =?utf-8?B?RkZ3dTVqa21Dcjl1R2xHNHVsU1lVdlhtV3VXcVd1Mk5mRTRJSzh4a29SYVNH?=
 =?utf-8?B?ZTI3SVRrS0srWTN5dVNDUy9kaENTTzRUdXRza1hhVUNvVmJuVmxGbU15TjI1?=
 =?utf-8?B?VkVkcWI5ZEFaWjVCNXYrQ2xMSGpGeVR1cHQ0czlzaG5mNXRHcGVuSEx1aDBW?=
 =?utf-8?B?R1hFS0pvTCs3dXFCY2lUYUNJbHA1dEd4RHRQcUFidG5iRWRkdUY0ZlhPdjVQ?=
 =?utf-8?B?bGNCUUY3UC9PTUp6T0Z4NmpqVkg2MXJUM044M0g0WW9wRGpON2VIcjBRc211?=
 =?utf-8?B?NEJvM25ycDZDQnN6bThCUzZPL3lMQno4bUE2c01ic01MNDZBOXA1OExvakdm?=
 =?utf-8?B?RXkvV2cyQ3lEaGFXdEpHNEVPUnZBVVlUa2JlOERIUWhhVmg2Z1FQdXhDS3p4?=
 =?utf-8?B?VklHTEtXcjNYdmdHNzg0bExyMHRoNHVjM3d3YWtTRHY3d2p6TVNyK1M5R0ZX?=
 =?utf-8?B?UXpiYUpVQkJNK3FyUVNnRDBQbFRFTkJsV09SaW0vaXB6Vi84ZFBQMXltZUUz?=
 =?utf-8?B?MmpCSXJudTVkNU5PWE53WUdhM2J1c01LOVdoMnBSVzdzTFliWnd3ZlRqR09E?=
 =?utf-8?B?cmRNcHltVkpOTjMrZkdDNmhUMkNYeGFFL2Q3c0JKV0grcVprRHdhQ1FwZ0sz?=
 =?utf-8?B?ZnlrTXNWakIrRGtJaTcwaWlGTUdpS0hIVHBDdnZPUE1abFBFYnJXcUNTOFRP?=
 =?utf-8?B?Q0NMSXJqYWthSkZwcS9iSGlqN0ZZRExoc0JOSkhldXZVVHMzem9iWXMyS1ht?=
 =?utf-8?B?dUhPZG5EQXByWUlWTXZySDNBRVBSdk5lQkQ1YWlQdTJmajVFSFA5VXlsN3Ay?=
 =?utf-8?B?V3dHdnh0VS9vS1BkZERYL25OTVFKcUFCb2JlUm9jTG9zOTJPdkRXYXBlVnNr?=
 =?utf-8?B?K0FvUXJrTXFFTVM3aFBEOHljcS91d0ZrV1lwbWhkYUFyVmF5TXhDZmVIRDc5?=
 =?utf-8?B?NTluU2ZZa3IycngzQ1V2SGhxa3hzTUtrUnFVQXRrbVJNZDQ1ak5WaGx6clhh?=
 =?utf-8?B?MGVUbCtocDVYUXZFaFRJclJFZGYwQ0UvUmd4OGhMQTJyVlEyMlZZUWRQOWlN?=
 =?utf-8?B?NTVxOTVDanNIUUFRWGo0YUVyM2dKMWoyQnlVUHlLUDU1enZ2eS9CSmM3clpl?=
 =?utf-8?B?VmorTFZRSnVYajZMTlFLc3pma0Rxa3hEaXJYRWR6OGt2YVBmZGY4VXZNdW9Y?=
 =?utf-8?B?YWtuRWk2cERFVE1SOUxQblRUL0QxMU5tOU8vR3RxTE44SjFJZThXWFZuTFJx?=
 =?utf-8?B?NXdpVTYyeHFtbUU1UHgxTExzbWlnUFpTSFl6UTQvWTVXNi9YQkREeVV4Rjhy?=
 =?utf-8?B?WjZUdUI1ekNjbE16Z3VFZXVmaE4yaFNUbEIvbTBCbjF6S1VWaVRxL1J3QXZE?=
 =?utf-8?B?MGJoQWYrVzBTNWxETW54MnZmM3pUVUd6TEcxWmEzb1BDcEdYR2tLYjVsZEtG?=
 =?utf-8?B?SFRUSGM0azloZ0pDclRVZWR0SmFZOUNNNERNWkpNbTV4ZkdNZ05HbDg0NER2?=
 =?utf-8?B?bGo1RzE5UTcwUkVmUUFxS0ZlWSt6WTdtNzZCN0RFUkhpYy9mWHZVbitnUnE1?=
 =?utf-8?Q?iDDA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d3720f-35c7-45a9-c865-08db56329786
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 17:25:49.3425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAAd9BIfrlZ3fej9Di5vb+uNUu2ySPePG5xdO/SxXpgG3vmwnp5Kg0XGIFHhx0ohZYespWomqYwu8hLI9kKFSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7179
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Pj4gSWYgd2UgaGF2ZSAnL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUwL21jMCcsIGJ5IGNv
bXBhcmluZyB0aGUgbnVtYmVyDQo+PiBvZiBkaW1tIGFuZCBNZW1Ub3RhbCBpbiBtZW1pbmZvLiBJ
dCBpcyBlYXN5IHRvIGtub3cgdGhhdCB0aGUgZGltbSBkaWRuJ3QgDQo+PiByZWNvZ25pemVkIHdo
ZXRoZXIgaXQgYmVsb25nZWQgdG8gdGhpcyBOVU1BIG5vZGUgb3Igbm90Lg0KPg0KPiBtYyAhPSBO
VU1BIG5vZGUuDQoNCk1vZGVybiBzeXN0ZW1zIGhhdmUgbXVsdGlwbGUgbWVtb3J5IGNvbnRyb2xs
ZXJzIHBlciBzb2NrZXQuDQpPbiBhbiBJY2VsYWtlIHNlcnZlciBJIHNlZToNCg0KJCBjZCAvc3lz
L2RldmljZXMvc3lzdGVtL2VkYWMvbWMNCiQgbHMgLWwNCnRvdGFsIDANCmRyd3hyLXhyLXguIDUg
cm9vdCByb290ICAgIDAgTWF5IDE2IDEwOjEzIG1jMA0KZHJ3eHIteHIteC4gMyByb290IHJvb3Qg
ICAgMCBNYXkgMTYgMTA6MTMgbWMxDQpkcnd4ci14ci14LiA1IHJvb3Qgcm9vdCAgICAwIE1heSAx
NiAxMDoxMyBtYzINCmRyd3hyLXhyLXguIDMgcm9vdCByb290ICAgIDAgTWF5IDE2IDEwOjEzIG1j
Mw0KZHJ3eHIteHIteC4gNSByb290IHJvb3QgICAgMCBNYXkgMTYgMTA6MTMgbWM0DQpkcnd4ci14
ci14LiAzIHJvb3Qgcm9vdCAgICAwIE1heSAxNiAxMDoxMyBtYzUNCmRyd3hyLXhyLXguIDUgcm9v
dCByb290ICAgIDAgTWF5IDE2IDEwOjEzIG1jNg0KZHJ3eHIteHIteC4gMyByb290IHJvb3QgICAg
MCBNYXkgMTYgMTA6MTMgbWM3DQpkcnd4ci14ci14LiAyIHJvb3Qgcm9vdCAgICAwIE1heSAxNiAx
MDoxMyBwb3dlcg0KbHJ3eHJ3eHJ3eC4gMSByb290IHJvb3QgICAgMCBNYXkgMTYgMDM6MTEgc3Vi
c3lzdGVtIC0+IC4uLy4uLy4uLy4uL2J1cy9lZGFjDQotcnctci0tci0tLiAxIHJvb3Qgcm9vdCA0
MDk2IE1heSAxNiAwMzoxMSB1ZXZlbnQNCg0KQnV0IEkgY2FuIGZpZ3VyZSBvdXQgdGhlIHNvY2tl
dCB0b3BvbG9neSB3aXRoOg0KDQokIGdyZXAgLiBtYyovbWNfbmFtZQ0KbWMwL21jX25hbWU6SW50
ZWxfMTBubSBTb2NrZXQjMCBJTUMjMA0KbWMxL21jX25hbWU6SW50ZWxfMTBubSBTb2NrZXQjMCBJ
TUMjMQ0KbWMyL21jX25hbWU6SW50ZWxfMTBubSBTb2NrZXQjMCBJTUMjMg0KbWMzL21jX25hbWU6
SW50ZWxfMTBubSBTb2NrZXQjMCBJTUMjMw0KbWM0L21jX25hbWU6SW50ZWxfMTBubSBTb2NrZXQj
MSBJTUMjMA0KbWM1L21jX25hbWU6SW50ZWxfMTBubSBTb2NrZXQjMSBJTUMjMQ0KbWM2L21jX25h
bWU6SW50ZWxfMTBubSBTb2NrZXQjMSBJTUMjMg0KbWM3L21jX25hbWU6SW50ZWxfMTBubSBTb2Nr
ZXQjMSBJTUMjMw0KDQpJIHRoaW5rIHRoaXMgc2hvdWxkIGhlbHAgY29ubmVjdCAibWMqIiB0byB3
aGljaCBub2RlDQp0aGV5IGJlbG9uZyB0by4NCg0KLVRvbnkNCg==
