Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3903558DAA4
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 16:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244720AbiHIO7m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Aug 2022 10:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244692AbiHIO7k (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Aug 2022 10:59:40 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90B91DA4D;
        Tue,  9 Aug 2022 07:59:39 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279EvBir021954;
        Tue, 9 Aug 2022 14:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=beLCDdrfCogOtCBpJFfvYpJ03UK9uOB8uFyo50CgRyY=;
 b=lUu7h3KsdacjrVtOnstJmWWQt03fPBTx1Xj6mMs+33VVgraqa6BIdkgCyagpAtKewb6R
 0CrOx9dQ9GSv52jngZDk3at5kvQQ1RibqRLDXnRs97K3vzkHI04AQrjgoVeyRXMlb2of
 qqKuxZ/mOeaThcPVTqMyHyzKQcC8job8q/WX+YkmT4NZvWb6dO1CiXXZ4P4EjvnQAzGz
 1z3ml7SFqe68hT2vwnBji8AphJ0FD/36z6fVI01h8A1O4DGEGhnK3YtfeUI1OQWOkbih
 xE8G2TBPNLXvPaLothzOdHAFdYr9V3ouOW9x9yJUdmbn4IrKBozDoIYi6Q3uPO+Tnunn Dg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3husr5r2t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 14:59:18 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 6F95BE5FDF;
        Tue,  9 Aug 2022 14:36:38 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 9 Aug 2022 02:36:38 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 9 Aug 2022 02:36:37 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 9 Aug 2022 02:36:37 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 9 Aug 2022 02:36:37 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdYb6reuPaA7wdtLmotHRnG4cLJwMBoaQHlJpQl196avPNp+NJSj2nBiMimaCWo2GdIykkFq33N7gRdI26VPyImqaX8+e+GCwzcjb+lPnf8K7sQ4XJUM3RgawYWd2KBfjCqDLEeo7h7Ojobczw+a3YRUFIfahJjlijvADMVGYxt++YkmFYTMSx2N+LwmotZRfxm0cemHTVJZ/yhj+a11hZr6h7fnCjHt3tNJqbqxi8q8yFOjZFoqodx2wtHLGntozQgsFs/xMbSb3iMqCTuOrD3Qn5hDlbOHUcvVdeiVHPI0T+Ae4Dbtp/ilFag/ME48wKsdGoprOVYZDCR1rN8ZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beLCDdrfCogOtCBpJFfvYpJ03UK9uOB8uFyo50CgRyY=;
 b=JMOLuw3kO+4UAP02ifdnYSpf7MN0ODMcrX2zB7Vu6MmRt1clqY3hFNrJVGv25hwq3ffhaYbW9lIQ19J4gHpEjfUnp6UcK4jJ2V2nDcprIUPbYEw768r8g9M11/1+aSCrqBwt4A/Iw9pLcr/6BGBLTg+F9F8al15yEYSAe7RHLcljNTZbMWXNP0gqWyoUo3lmL8eztbqz59lJiIVwVs+R7wRwdlNVJ2vYXzWlaJsPvB0aEsRmilmlvtpHfM5lziku9pGs5kngssZ9ipnsWCChRFTV7qbYOzQGxItiW9+Y1oYCJLZbBDKwo07pJP7VhZhvMg8OW4yir7i8WBrZbA0btA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by MW4PR84MB3172.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 14:36:34 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d%6]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 14:36:33 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, Justin He <Justin.He@arm.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Subject: =?utf-8?B?UkU6IOWbnuWkjTogW1BBVENIXSBBQ1BJOiBBUEVJOiBtb3ZlIGVkYWNfaW5p?=
 =?utf-8?Q?t_ahead_of_ghes_platform_drv_register?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIEFDUEk6IEFQRUk6IG1vdmUgZWRhY19pbml0IGFo?=
 =?utf-8?Q?ead_of_ghes_platform_drv_register?=
Thread-Index: AQHYq1YbHdpOiV0alEuUJHkPzB7Jbq2lceiAgAAKR4CAAADVoIAABbmAgAACeaCAAKrLgIAAHP6AgAAfFoCAAC4DUA==
Date:   Tue, 9 Aug 2022 14:36:33 +0000
Message-ID: <PH7PR84MB18380596CA00597E9D5D18DF82629@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220805023200.154634-1-justin.he@arm.com>
 <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
 <YvFX9vTilqMpsF9u@zn.tnic>
 <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF4p01WJGGUwIJC@zn.tnic>
 <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF+J/dfyOEVSbSQ@zn.tnic>
 <PH7PR84MB1838BF4F8B56EF1E24FCF1DC82639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvIPf/m3hU46S9Ik@zn.tnic>
 <DBBPR08MB4538A5C080B09A96A77CCDA9F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <YvJB5cxSldpigw1g@zn.tnic>
In-Reply-To: <YvJB5cxSldpigw1g@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8460d7c-b0c4-4f13-ecec-08da7a148eae
x-ms-traffictypediagnostic: MW4PR84MB3172:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uNfLnFkV1nZyW4O/m8aLD6ErPol90vzBT1QnAtjiv4rrMGDnCHZ+mTPeEXh8v64R91L8zO75Yps0lKo0IvRjkhX8nA1eowkmmo/eZdZnHuLuVei5QMNWiowuvF/D/eo8u5XT5XxS7v7e8SUoBoe0LUWtsgyB6lmQxpr3Ul5DeOUQDBRr6O5s4XM5BXg7X7rpw90Dc3v8z17nwRXLt7nmTtWOh0MBJUv2rwu+MT2HHfPcoea3LTb9WR87LaafnpfpXR5qwFO8NnGeJjaSbFYZEk0yC/frBPZnEeHrPNZpU0ygL4Cy0WH/tyiuAZ0/qFxgnDOCe1Va7g5hKucWfphkY9y7LHNHE19/mrNT7xaITAsQFfO5hiKWORawG2c8mfjoQLYE/gzM7xPsPKFSWLLQrq8rzH/XQsSeQOIDBzgQmdLV5vWBsiIlQeXUZo0bQ47Rv51SuNrOu8DJneOyAFzv1T0vctmrrAQ7pIdTKo032LfbmWoj1M3ksYielBPtNfVTAvXmwkfYSRDbCZGAn+t3+ruV7CI7wyLH+B80gLjfMWMFCfNDG8Yl4KTe5iAJWi80epeX37A3JMx37jmC6mZTE7qMo9wc+9aXSWa4c/ewDgMCD8qZopWgHzTl5HlHsgjWfc6JLiJfjcbqC8nr30lEbF2K8YDqkZ+xQT3smK9WQWsYeLk9vcaG7ve6ca+uS+UEiiLBqCn+6mWNS87F1eWbT1R7978LvYBuQ9UKiiiSLieoHWIa8a7r7CB2ckPBC+ucqWs3E37/Sggwv1IiEgOD+4VNlDKijvc3HrW8nBdRsclGnuxqQoQSF351fYbvM3za
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(366004)(136003)(39860400002)(53546011)(26005)(7696005)(6506007)(83380400001)(9686003)(38100700002)(186003)(38070700005)(82960400001)(122000001)(52536014)(8936002)(5660300002)(76116006)(7416002)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(55016003)(2906002)(478600001)(71200400001)(41300700001)(110136005)(54906003)(224303003)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2pwVXZnNGZCKzJBWVM1VkcwQWY0ayswOGJOVUErTXEvT2g5bnNWRHNTOTY2?=
 =?utf-8?B?Zk5iRm5IUTBhN05zeWZWZTRNVE5KTVpTUnd0emJ3S1l0QUZYcWZwSFZjcW1B?=
 =?utf-8?B?bm9yVzVzMmxFVnY1SmlkTTdkWGJlUHk0WVIxUDgzcENWM2ZsMXZqTkNERTdx?=
 =?utf-8?B?SkNtMXlsdWN1SzRiTk5BSGZoQWluazM2VlpJenB4Wjg5RkN1L0NEWUo1SENv?=
 =?utf-8?B?RjdqMS83QVJMenN3d0Q3WjdSbmhGQWcySXB6U2dpWjl0MnE0QlllZDY2YW5u?=
 =?utf-8?B?MkNKQXZ6OUxxQW1CTkFFMjEreGF3ZmIzQVZ2cG42Zzh4djRobTR2cm5oWmoy?=
 =?utf-8?B?N3c2S2plMytqUjF5cTJMMTN1dXZ1WFpZT0JMWVRJVG5JbU1adUdPKzBEc25x?=
 =?utf-8?B?dGNQdXllM3YvS25pdUZCVjIxN1FvSkNQSXZRbGZHVFNZMUxJZXV0TjJUWThs?=
 =?utf-8?B?QkYydVU3bXYvM1dhQ3NEK2RIZGRSUEFDUktUTTg4WDIwc2o3dUZFaGtaVXkx?=
 =?utf-8?B?VnpDVlVEdlc0ZzhDdVdoY2NnWHFxbjVHa1kzQWxCNzEyV1ZVR1E2QmRnRHJK?=
 =?utf-8?B?Zmt1c1ZPRGJqOVpZSzVDUFQ2dnNVRHVQdUVmcm5QUEZTdGkyUGhJRyt5eTlE?=
 =?utf-8?B?VTVyL0NCTHBFRlF4UDdpM1Q0TkhzUXppc0UvYmlmYm1DSVVaZ1ZjYnRYbmRQ?=
 =?utf-8?B?Znl2TGRaUnUwVEh2M3dULzV4dTEzUnUwUWZGV082MjRWVEtXb1F3VTZPT0pZ?=
 =?utf-8?B?T2tkMm9VbzFmMjlSNjRpdkZjanFiSVJFY05EWGxNTFlmeTk1ZnRlcTRkOWFK?=
 =?utf-8?B?UmsyeTFJTUR4Y1hrZElnSjc0VzR0ZlNYU2NWSmIrQy9tQ1NGbTVtNm44MDNn?=
 =?utf-8?B?V2dUeTlnbkRpTmRmOFlZbmVHSERGZjUwaXJvejZES1ZRaFhQQW1JbjBEa1d6?=
 =?utf-8?B?U2pxcG5SWDNCallrb3dMcDdMWktrZ2VZS2l5b0N0cm1IQUZTK1h4ZTJkNnBH?=
 =?utf-8?B?VmdLMHhydk5mOWRCYzBDUTlDcmtVL1BoVVNETEZKQ21WVXhybHZGdnFrRCt5?=
 =?utf-8?B?Tyt4Uk9SNWhOWUhxWVVlcGhoaXZjQlJIR3ZZS2JQWDNvRzdqakNRaUJaNjVv?=
 =?utf-8?B?K0JMeEw5QXZNNWFkVlRMQUxFMnpOSU53Z1VkZ2tUbWFhbW93ZmVlTGFRUGJn?=
 =?utf-8?B?bU1BZXZ5bDNWTllHNklSS0haaWtzNFB3VmhzVWMzOVR4V00zbDFzTHJKRkhr?=
 =?utf-8?B?bzhhZW9ZNnAvcG1xeXQrZHlwUmNwL0FQaUtmZG80RU5NYXdoOFRXQmZJbHdu?=
 =?utf-8?B?Ykh5R3RFdDlKbmtEUEVNd01nSnZ5V3V6UXhsdEdkd0l4VytYUThuV0V0YkZR?=
 =?utf-8?B?bloyNkV4TzZ6cmg0bFR5eEw3QWlNNTJGS3RWamhCbDNicml5Ym1FZUVyRndw?=
 =?utf-8?B?RGZJcVpWTGdQWGNrajRKTTF3VUsybEw4akduQkhZUU80QWtZTGk4a0U5dWtu?=
 =?utf-8?B?NlFJTjNwVE1CaWZoSjUxbllHaEwyK1lJejlkTUh6SUtiWndXRm5hSGRkdWUy?=
 =?utf-8?B?Q1BML0NEVWswRDkvRmVhYTNIelNNSlMzSUk1V00yWHNacDlnc256OThZMThH?=
 =?utf-8?B?VEZYYkVHUHgrOGtXQm9pRGk1VlFTZTJSTDRKZm9PTmNtQlluTlJmSjRRV2J6?=
 =?utf-8?B?d0pyQ3JKeUhsLzFBdHpJNXYrS1FQcmh6MXVLRGpTOUZYZWx2STVJZzY3dyta?=
 =?utf-8?B?c1BjbTBOTzczMi9MSGltL2tvUXJBZGIzSEFRNXgrNDR1ZEVtMStUZzBXNE41?=
 =?utf-8?B?NUFUZFc4NnIwRUJ4ZWlmZzdHOTgxRXpDdW5rdjhlUU5FbkVIYjZuU0pvWUVE?=
 =?utf-8?B?M0NETmppdy9uRVFScUtUUnJTbW5UK3ZvbERSQkIvT0ZyZENpN3dKMzAvd2JQ?=
 =?utf-8?B?Q0w5cGxqVTVNd0FRZDB2THNGQ3dEbkFhMEdYSzdsdkk4NVpTT1hYY0k2aEY3?=
 =?utf-8?B?UjBTYXNXS3AyNWVZeHlDWlBvbHRoRHFCZlR0TVk1QnVFU1NvdUQyVTI2dDZR?=
 =?utf-8?B?VFV4Yk55dGNvbjdsa1ppQ21hNnlDMXZkamZSc3pLejQ0NDk3OXpsZElmR0pS?=
 =?utf-8?Q?K3Rl1cWNwC4fGp2Sv7+epHeDT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d8460d7c-b0c4-4f13-ecec-08da7a148eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 14:36:33.7483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F1rw8TLEqr6QqLnG7GUjm/d5FQuy4Ssf/Pd1Ed+OqozTbv9nZ899tr9ekwqKPO1ygUQUBk31psPm85SCqVsrSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB3172
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: D9OvlX6oqwM5FyKfb3sa7tdV0YjVEnE4
X-Proofpoint-GUID: D9OvlX6oqwM5FyKfb3sa7tdV0YjVEnE4
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208090064
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gVHVlc2RheSwgQXVndXN0IDksIDIwMjIgNToxNiBBTSwgQm9yaXNsYXYgUGV0a292IHdyb3Rl
Og0KPiBib29sIGdoZXNfZWRhY19kcml2ZXJfaXNfcHJlZmVycmVkKCkNCj4gew0KPiAJaWYgKElT
X0VOQUJMRUQoQ09ORklHX1g4NikpIHsNCj4gICAgICAgICAgICAgICAgIC8qIENoZWNrIGlmIHNh
ZmUgdG8gZW5hYmxlIG9uIHRoaXMgc3lzdGVtICovDQo+ICAgICAgICAgICAgICAgICBpZHggPSBh
Y3BpX21hdGNoX3BsYXRmb3JtX2xpc3QocGxhdF9saXN0KTsNCj4gCX0gZWxzZSBpZiAoQVJNKSB7
DQo+IAkJLyogaW5zZXJ0IEFSTSBsb2dpYyBoZXJlICovDQo+IAl9DQo+IH0NCj4gDQo+IFRoYXQg
ZnVuY3Rpb24gc2hvdWxkIGJlIGNhbGxlZCBieSB0aGUgRURBQyBtb2R1bGVzIHdoaWNoIGNvbXBl
dGUgd2l0aA0KPiBnaGVzX2VkYWMuDQoNClRoZSBsb2dpYyBuZWVkcyB0byBiZSBsYXRjaGVkIG9u
IGdoZXMgcHJlc2VuY2UsIGkuZS4sIHRoZSBjb25kaXRpb24gaXMNCihnaGVzLXByZXNlbnQpICYm
IChnaGVzLXByZWZlcnJlZCkuICBDdXJyZW50bHksIGdoZXNfcHJvYmUoKSBjYWxscw0KZ2hlc19l
ZGFjX3JlZ2lzdGVyKCkgZm9yIHRoaXMuDQoNCj4gSW4gdGhlIHg4NiBjYXNlLCB0aGF0J3Mgc2Jf
ZWRhYywgc2t4X2VkYWMgYW5kIGFtZDY0X2VkYWMsIEkgZ3Vlc3MuDQoNCkFncmVlIHRoYXQgY2hh
bmdpbmcgYWxsIGVkYWMgZHJpdmVycyB0byBjaGVjayB3aXRoIEdIRVMgaXMgYW4gb3B0aW9uLg0K
SW4gdGhpcyBhcHByb2FjaCwgdGhvdWdoLCB0aGV5IHdpbGwgbmVlZCB0byBjaGVjayB3aXRoIGZv
b19wcmVmZXJyZWQoKQ0Kd2hlbiBhIG5ldyBGVyBpbnRlcmZhY2UgRk9PIGlzIGludHJvZHVjZWQu
DQogDQo+IEl0IGFsbCBkZXBlbmRzIG9uIHdoYXQgcGxhdGZvcm1zIFRvc2hpIHdhbnRzIHRvIGxv
YWQgaXQgLSBJJ20gZ3Vlc3NpbmcNCj4gSFBFIGhhcyBib3RoIEludGVsIGFuZCBBTUQgcGxhdGZv
cm1zIHdoZXJlIHRoZXkgcHJlZmVyIGdoZXNfZWRhYy4NCg0KWWVzLCBhbmQgSFBFIHdpbGwga2Vl
cCB0aGUgc2FtZSBwbGF0Zm9ybSBJRCBmb3IgR0hFUy9GRiBtb2RlbC4NCg0KPiBPbiBBUk0sIHRo
YXQncyB1cCB0byBBUk0gZm9sa3MuDQo+IA0KPiA+IEJlY2F1c2UgSSBub3RpY2UgdGhhdCBsb3Rz
IG9mIG90aGVyIGVkYWMgZHJpdmVycyBhcmUgcHJvYmluZyBsaWtlOg0KPiA+IC4uLg0KPiA+ICAg
ICAgICAgb3duZXIgPSBlZGFjX2dldF9vd25lcigpOw0KPiA+ICAgICAgICAgaWYgKG93bmVyICYm
IHN0cm5jbXAob3duZXIsIEVEQUNfTU9EX1NUUiwNCj4gc2l6ZW9mKEVEQUNfTU9EX1NUUikpKQ0K
PiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiANCj4gTm8sIHRoYXQncyBhIHNp
bGx5IG1lY2hhbmlzbSB0byBhbGxvdyBhIHNpbmdsZSBFREFDIGRyaXZlciB0byBsb2FkIG9uDQo+
IHRoZSBzeXN0ZW0uIEJ1dCB5b3VyIHRlc3Qgd2lsbCBnbyBiZWZvcmUgaXQsIGF0IHRoZSB2ZXJ5
IGJlZ2lubmluZyBvZg0KPiB0aGUgaW5pdCBmdW5jdGlvbi4NCg0KV2VsbCwgdGhpcyBjaGVjayBi
ZWluZyBpbnRlcmZhY2UgaW5kZXBlbmRlbnQgKGxpa2UgR0hFUykgaXMgZ29vZCBhdCBsZWFzdC4N
Cg0KVG9zaGkNCg==
