Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C88270C4D7
	for <lists+linux-edac@lfdr.de>; Mon, 22 May 2023 20:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjEVSCf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 May 2023 14:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjEVSCe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 May 2023 14:02:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27181FF;
        Mon, 22 May 2023 11:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684778553; x=1716314553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2L0syIxe7caH/tKuqGTmc53RhKGt9kreSkp+gYneIAs=;
  b=PI0IDfW9V8nX1sGIlkntsbyYT4mRYkFG8hFUm8dc8PZWcgUaAf50KBt7
   9wbysUHeM3pMSc05FVKP8E+R8A7OtRnSWxsdsY7LB/nQng4kqIRVU2SXz
   U6Vr7dXgudsfuPJ8XI4YqQs5vdFnnQpzsm2f7HdutCK+0iD4XTjsLW8lH
   mgTT+ZaaEJ1FAvKpu96wu97OpUtaUvyQoCZFf+ND9kv49/PNWXKmMUMS0
   +GUxG3MZwhrV0GVkuNkUrzlhp2Vi/ujWiRr/F0h8ZcV7OocoekoiY1ws9
   2QVPD3dbgzCGWCWQVBdP1MAVYzfRgUZwVrsM0xjhoS4a+lHvPL9suF3z9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="418706167"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="418706167"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 11:02:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="773446631"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="773446631"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 22 May 2023 11:02:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 11:02:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 11:02:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 11:02:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 11:02:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ4kF25idIOTaESy+FFtCkhEV94c84+J8HxixMD4O/Vsnr2gE+VJUebgxZMOsjm4ODocQcqIJHFqjfSOazPEBfxW7rRP9xCnBM7m3/eVo9jFzaVU1fLwa/xrdGizjbwZaoTEL8EdN7z2Kle5QeV6VFw/yFVtle92OExcL4eSK8ZHqdLdHy3UMHDSfWlzo3+AzCEusDRYk1l/nXfUi2ChP8rjv7NnlzN+ddLD9C3UT3dqE+gkRn7gDMMF8EALeRPn6OU+92KAPPuZHMdGpGsUUlk+0csQuWddjpUalixf4LiLX/WrBjHxw7dbxrgMGSV1Ma3390sUUbGDW0KLpUtSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L0syIxe7caH/tKuqGTmc53RhKGt9kreSkp+gYneIAs=;
 b=Y1vqbLasp284gJjEYRmO65kRRI1omc1N/TJCRUyAmGo4/RqGEp3JjBLeMF5KxsK8rDkzj95rYYHDJ9CzKWrY80D+J2Kd3afjkUBw6gQMQCNTqNIKxMKBSBk2mqi2IlDU/60c6/M7nup0uTU96pv6QgYgFEKj46vDKon8GtkLXo4115d5K8YjntLnA9iYACkcUItBlpnNoH1Bg3+rjk0iM4a12LSKlwF6JHcf73Xad038W8J1gKFPKMjEKzrhuerTXHGwaXINiJ4G/2u1pQUbpz2m6152hdHt7EcLvKcvkwQ/oPBOdVGP3IaFEVJMMvF4n4yVYm67mwKhS9og9A8FyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB4819.namprd11.prod.outlook.com (2603:10b6:303:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 18:02:29 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6387.029; Mon, 22 May 2023
 18:02:29 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "chu, jane" <jane.chu@oracle.com>
Subject: RE: [PATCH] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Thread-Topic: [PATCH] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Thread-Index: AQHZgVImNOtr/f0xT0mC0EpzAZOge69fVySAgAKAqHCAA76GAIABE0Fg
Date:   Mon, 22 May 2023 18:02:29 +0000
Message-ID: <SJ1PR11MB608309996658741A534D39D6FC439@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230508022233.13890-1-wangkefeng.wang@huawei.com>
 <d13b2730-bc20-3e32-a6c0-44c525ca9f0b@huawei.com>
 <SJ1PR11MB6083194699B63B199A2B5199FC7C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <75d8452c-695b-b22a-30d0-15302cd072ef@huawei.com>
In-Reply-To: <75d8452c-695b-b22a-30d0-15302cd072ef@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB4819:EE_
x-ms-office365-filtering-correlation-id: 5fbcce8e-86b2-4b85-bb9f-08db5aeeb56e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6tmYRqSD6XPCXB37mAjX44wZzn6m+JqMhE+LnSPCRkrCktU19+JtGS4zDtcobLSXL4r98KkouKnhIL8EIT5ovBWxFNeT7AGKyJAcwPz5nUizc6LA+rPFuEPiSxbW5XdjKUiYS8hIVkfgh4ES7OayWiwgM/nYuMaazYoGsiHPXVOklH9h7lqIAG+OVDEjvCc78CuqVJLRJPJmmv3xxk0+Ga/sJTByotX8KbMJRQQwjYzy0LYivYeAXBmiutrZaPgDEN7ylAgbI7hbjSQhJS4poyICITaf3s3vxZ04sUHksY97AQj14heGeFyVYsQitWe85j5W97bPPz1HcdyvVV5ve06PsbIzFTceu57WQj4q5/ZGRFiIpwrxZYWCBTW0Is4B86lZ7jHBbW4IOZJv/+DkS4xUfCYX6kURC52E/sK9a5FTukHzqrqPTH/MvwPp2FKlZqI+D+xvSo9RssYUu5pcvP+QmB8T0RdTCJemGUBhI1idXOKUxijVRNlFDIqgNtuD9eyk+nASTGJbO0cPVhGpJPY/peMjxgSutXZ9R+IWE0vr3Kn/eoGYR0mqXdQQVjS3vMHlZNltuFEt+zUXQ93Ea6rZMZjsrfXEvI8qH76W9nD0iTUCPmHatqYz6fBvdl+q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(8676002)(8936002)(7416002)(52536014)(5660300002)(83380400001)(9686003)(186003)(6506007)(86362001)(26005)(82960400001)(122000001)(38070700005)(38100700002)(55016003)(76116006)(41300700001)(71200400001)(66446008)(7696005)(478600001)(33656002)(4326008)(66946007)(64756008)(66556008)(66476007)(316002)(54906003)(110136005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDNuR0NObTQwQzdSNC84TEFnSzllaDV5S0YzWXdiMGZwQ1NKbXFZMWFhWkFi?=
 =?utf-8?B?SStpWUxCKzNmSUxlT25oZTJsZFVYUHQrVXRVOW0rQ1pSazhndWdwMXVTMGhr?=
 =?utf-8?B?UFl1cjBhMFRSSU1LbmNURncrWGR6aS9hMGZVZWpyaE0wQlBmOXpoTkJTaVQ5?=
 =?utf-8?B?SXdtdHZXVVlCNlIwVFZvUSsrMENEb1NVSW9FVHdIRWYvR1NDSEptanhsRnl3?=
 =?utf-8?B?anZrRTlSWG52UWF2MXF2TTNza3lPajVjeHVQVzBPZmpFZDFsMFNhT2ZZWUNO?=
 =?utf-8?B?VTBDNFlyUEJ6am5OalFua25mdmpiZnBxR21uTnd3NEpUL01XcStobU50TUtY?=
 =?utf-8?B?a3Y3MVM0bmFBK09vZ3lJMVUrR2VIK21ubW9EMFFCSkVSdzRLM09jUC9SZ2xj?=
 =?utf-8?B?WXdIWE4yVXVJMXV5cnhGRGl0M3loZG1leVE5OCtlOWQ1cjQ3YXhrRElSYlZa?=
 =?utf-8?B?OU9Ed0xFWENITy9ITUUvbFl5d1JwVk1TVzNWWHY1azVNNzRjaG9rZzRMM1V6?=
 =?utf-8?B?NWd1VmVSZ2J1TjAxVUt2dWI0dHlteDlYa092bXIva1JSb095Q3doRDA4TGZ5?=
 =?utf-8?B?N3J1M2kvMHlsdXRaNG1KKzJmSGV6SU05c3Uwa2kvdk5FMlYxOVJHYmZ1NmZv?=
 =?utf-8?B?VnZpZmFpOFJtTUJzVHk3L1NwZC93eTkrWnJzNmlFTFY1SG5RUzAzZjVLWmcz?=
 =?utf-8?B?WUkxSDVibGsycXhqdEFobmJjSDJDSGFrSlR1Y3M4cDM3T1ViZ2VVd1ZEMVpY?=
 =?utf-8?B?QTh4ZmltV3hBWEJmMndNZE5TREpmT0hQc3VJS2dabm5iRmx2RjlKOE1jV2lN?=
 =?utf-8?B?M3AvazBtUkI3RnhDdUtReWJJUlJTNFNSM1MrOHQ5VVRuTFNCR0NiZWpGcXov?=
 =?utf-8?B?b0FtaUdqRDVPbk1tSkdlVmJVQWVhM2FXTktiMlY4QW9ZSW5SSFdaTVhmWEcw?=
 =?utf-8?B?TktXR2p0dVNhQVNjUk40bnFVYzZWbHZodTBuVmN0MFRUTWVmTFhEYnRmella?=
 =?utf-8?B?TW1ZV0EvajhLTnZhQk45NmpQaW5ndHFta04yZUtHQWZzWCtPOEpnK0MrMnhD?=
 =?utf-8?B?eFQ2TjBWY1dPdTV4eGhzdmhmSEtqVDZpMjBPeXlZQUpWemd5QTJKSlpPVkcw?=
 =?utf-8?B?NTNWcnpxVDZLbUtYYk1UWUZaNlVaMDZ5L1p2MmsxOHR5VmNheHltT1lFWGRM?=
 =?utf-8?B?bDlZcG4rdjhBcGNtbjQwMjhRc3Y2Y2RqTUg0dzAvWm94S0N2T3NJOUJMUVQ2?=
 =?utf-8?B?WTYxWVdYL2dlUndlMDdvc3VlZis2VEpZcUcvMUdhOGdwQnlRMWtjTzJJSzEy?=
 =?utf-8?B?MklWMzhlUzA5STR4bTV2clp3R21ZZGc4d29JMldvYnRxUjY0dlN4QklRNkFT?=
 =?utf-8?B?MnNPUTVMcThCT2kvb3duaDlJYTFiWlkrY3FXb2swdHB1RExPSjFLMmNXc3dV?=
 =?utf-8?B?d2RVdjVVaUFzR2ZZNTdJSjV3UkhOendFRE44VjB1YUNkZm5MSlE0UWFwOWdF?=
 =?utf-8?B?ZmxOaXVkSE1kTkpEdEJUemt3TXRrR0swR2c0ZTJsaWJUQnlEbzczR3MzMFlp?=
 =?utf-8?B?am9sMW1BV2YxUFY0cWdndG5rTC8ybXhuK21yT1FZejMyV2ZxTm5OZHVkdStx?=
 =?utf-8?B?K2FWZEduV2lRRXFwRWVYMGZmV1hVNDZzT08vcU1abWNBRThKdFVuem9NbDlh?=
 =?utf-8?B?czUvOUtiaTgwdVBscndvVFlwRnpoVzJ4eXlFTDhyU01JYk5EY08yYWxTZVdv?=
 =?utf-8?B?UXRldVo0eTdJeUJTYm9TOXlqc2djM0tRUjFpYjVlWlN1RjFGM3ZWTVBhNHB6?=
 =?utf-8?B?YjIvaG5nam1lL3BScWJrODdVa0hYR3FucUR2KzA0T1ZRa3dyRDc4YzNmamE3?=
 =?utf-8?B?ZnlXRkxBOXZmR3ZLTEFGK2NxVUU0Wm5QZjBJSkZFRnM0OXY3bkxlVUQxNU1Z?=
 =?utf-8?B?OFpyc2pyeEFoSmc0UkNQQ05wUjNQQXhjVXc5Zm5XSGRhWEFrcHNnZnF1eG90?=
 =?utf-8?B?YnR3VmQ5MkhMWnBUWDRFeWZjTExjYXM2a0I1OHBhQmsvMFJEOTg5YTYxMUYv?=
 =?utf-8?B?Q0l4NWlrc3dUSGFybWRyUFJYWGducVZBc1ZCN1VRQitrTEkzU3o3L0hTVHk3?=
 =?utf-8?Q?a4AA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbcce8e-86b2-4b85-bb9f-08db5aeeb56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 18:02:29.5261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItM01/GcsZyPu5PFZhOx+wOMb2T9AzAHFesqzSUCBtTavw5ABaVFvVMHaMg8Wc3dicVoBHduOlBTN+suOtXv0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4819
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

Pj4gSXMgdGhpcyBwYXRjaCBpbiBhZGRpdGlvbiB0bywgb3IgaW5zdGVhZCBvZiwgdGhlIGVhcmxp
ZXIgY29yZSBkdW1wIHBhdGNoPw0KPg0KPiBUaGlzIGlzIGFuIGFkZGl0aW9uLCBpbiBwcmV2aW91
cyBjb3JlZHVtcCBwYXRjaCwgbWFudWFsbHkgY2FsbCANCj4gbWVtb3J5X2ZhaWx1cmVfcXVldWUo
KQ0KPiB0byBiZSBhc2tlZCB0byBjb3BlIHdpdGggY29ycnVwdGVkIHBhZ2UsIGFuZCBpdCBpcyBz
aW1pbGFyIHRvIHlvdXINCj4gIkNvcHktb24td3JpdGUgcG9pc29uIHJlY292ZXJ5IlsxXSwgYnV0
IGFmdGVyIHNvbWUgZGlzY3Vzc2lvbiwgSSB0aGluaw0KPiB3ZSBjb3VsZCBhZGQgTUNFX0lOX0tF
Uk5FTF9DT1BZSU4gdG8gYWxsIE1DLXNhZmUgY29weSwgd2hpY2ggd2lsbA0KPiBjb3BlIHdpdGgg
Y29ycnVwdGVkIHBhZ2UgaW4gdGhlIGNvcmUgZG9fbWFjaGluZV9jaGVjaygpIGluc3RlYWQgb2YN
Cj4gZG8gaXQgb25lLWJ5LW9uZS4NCg0KVGhhbmtzIGZvciB0aGUgY29udGV4dC4gSSBzZWUgaG93
IHRoaXMgYWxsIGZpdHMgdG9nZXRoZXIgbm93KS4NCg0KWW91ciBwYXRjaCBsb29rcyBnb29kLg0K
DQpSZXZpZXdlZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KDQotVG9ueQ0K
DQpPbmUgc21hbGwgb2JzZXJ2YXRpb24gZnJvbSB0ZXN0aW5nLiBJIGluamVjdGVkIHRvIGFuIGFw
cGxpY2F0aW9uIHdoaWNoIGNvbnN1bWVkDQp0aGUgcG9pc29uZWQgZGF0YSBhbmQgd2FzIHNlbnQg
YSBTSUdCVVMuDQoNCktlcm5lbCBkaWQgbm90IGNyYXNoIChodXJyYWghKQ0KDQpDb25zb2xlIGxv
ZyBzYWlkOg0KDQpbICA0MTcuNjEwOTMwXSBtY2U6IFtIYXJkd2FyZSBFcnJvcl06IE1hY2hpbmUg
Y2hlY2sgZXZlbnRzIGxvZ2dlZA0KWyAgNDE3LjYxODM3Ml0gTWVtb3J5IGZhaWx1cmU6IDB4ODkx
NjdmOiByZWNvdmVyeSBhY3Rpb24gZm9yIGRpcnR5IExSVSBwYWdlOiBSZWNvdmVyZWQNCi4uLiBF
REFDIG1lc3NhZ2VzDQpbICA0MjMuNjY2OTE4XSBNQ0U6IEtpbGxpbmcgdGVzdHByb2c6NDc3MCBk
dWUgdG8gaGFyZHdhcmUgbWVtb3J5IGNvcnJ1cHRpb24gZmF1bHQgYXQgN2Y4ZWNjZjM1MDAwDQoN
CkEgY29yZSBmaWxlIHdhcyBnZW5lcmF0ZWQgYW5kIHNhdmVkIGluIC92YXIvbGliL3N5c3RlbWQv
Y29yZWR1bXANCg0KQnV0IG15IHNoZWxsICgvYmluL2Jhc2gpIG9ubHkgc2FpZDoNCg0KQnVzIGVy
cm9yDQoNCm5vdA0KDQpCdXMgZXJyb3IgKGNvcmUgZHVtcGVkKQ0KDQotVG9ueQ0KIA0K
