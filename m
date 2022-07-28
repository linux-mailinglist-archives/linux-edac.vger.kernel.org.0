Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5FF58470C
	for <lists+linux-edac@lfdr.de>; Thu, 28 Jul 2022 22:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiG1UbN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Jul 2022 16:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1UbM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 28 Jul 2022 16:31:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0D35004D;
        Thu, 28 Jul 2022 13:31:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SKIsaS019698;
        Thu, 28 Jul 2022 20:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=066mrPTowXawnhjvQcPluuk1V1w54Ke60AnyZIlSxso=;
 b=v1+k0r/jkAcfgZwraQAIQ0r5vxgt58ffP6QUGyTPWjoDGJogNB+EzYTNBUX+XbjJk9KY
 AmgAkk/ROxyVM0KwSevrH6EizilBl1qOCbRbfzD4ILn58L3SxNDCQ1wwyVgNuCG2D8WJ
 ZK9l/s8ymFUhvXKJ5rPkw+Mo9nCReHQ/6gW5UgpSU77a9Wp2ic8vZbA6P0/fdEmND7mm
 tp0jdkpBMiysrHX2H1cMJlfkSH+s90EE2uWAytzCcBVO/BdwgdXQQXnvVcPKjn+il1fi
 Zw/7XVFROUXPkqg8ZU1hisSmuNeKRb1amqhISWmJl7oqBFzxDQYBZjE3ikjj/4bfaByu jQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a4wtu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 20:29:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SJPQqu029536;
        Thu, 28 Jul 2022 20:29:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hkt7c8duq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 20:29:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mceqVC9nYQmjBAiwpJczlC9SDtLQ9DM3vB48aTx573S/U8vy0U5clhSYjj0XpFhfeapIrBtBSFcd1IcMM7FyvYyYqUZ0J2y+xow0fm3I13vdXZiP0T0i9TUTOX9hXkV7dS0Y2r4Bdqd+1HXZfKn+xmoQW4T07A/eHmjeCkVgAjWzvM+/GLC4YTAbDu/sT5e0jzRDv0E9PB7n/gMGGErApENyQaC4+JRI30Rw9xvEyxAvW4ndEzsSPJAeU87wQZ7g+kPcFmut7IU3jwLEcEPSDz3chyM67b0mlYWmK2SYTnhnBqDlat4Atm7afoBeqNUFf/NuayX6QiaCFHiJGcsS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=066mrPTowXawnhjvQcPluuk1V1w54Ke60AnyZIlSxso=;
 b=kUvOoBZ+CnnC3f0buLVWzbysWLyGIfWSuzOrgVKbMoaHgphmM6meAMXguE+6ajQ4SPI1Ju89ypb4WH4ZOIC7+h4VZ42pb3A7kPpgunf3vWO2Ymy3fi2kRIMS71MnOWkvhi/8FRK13tXmo9KFTHAjeMv2bR8sA638SmkKfggImkoCo0/LObaCIv1jKrM4IIyGiRJPvkNYWA37qS0ntw73uRGo1PywY88Dj6OL8M6kJRCruaXTtk8KG0b1xW+MCBh6kGiw9bUUWe79nJIe9fihkyPyf7bzWzFlu/W1t8TZaGQXuoPDq4XoWkYxkgJ2Yi5CKKodkCHpNZTBlzdhVzfR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=066mrPTowXawnhjvQcPluuk1V1w54Ke60AnyZIlSxso=;
 b=tUhC32D5fpLUETr+AHyh85hTSOU2EKBhkoIhxylbLAg71X7+dGUk1EUENQQoRpUJf7Ny+x3B2nsU286RrROC1UGUTJWWPGljyAF4WojbS9KXMccjNu49G0AZ4PlXij2CLJLsypf1GKQLMpG8D8l6TqPc2WFwFUbZx0ik6WID2uU=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CY5PR10MB5914.namprd10.prod.outlook.com (2603:10b6:930:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 20:29:38 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 20:29:38 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v4] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYoek9ERW6GrarlEiLoaZlsaluTK2SkWMAgAAHxACAAAGfAIAAAU2AgAAHboCAAXk6AIAABBUAgAAc4IA=
Date:   Thu, 28 Jul 2022 20:29:38 +0000
Message-ID: <2260c16e-7bb9-7315-5d5b-8656ca1ba93e@oracle.com>
References: <20220727184644.2685405-1-jane.chu@oracle.com>
 <62e18a687aac2_2d20792944b@dwillia2-xfh.jf.intel.com.notmuch>
 <f22faecf-b4ea-cb39-bed3-3647842b814e@oracle.com>
 <382e9410-d964-5600-4481-ccad90dbc97b@oracle.com>
 <8e817134-bfa9-72bc-3601-eeb1a138fe37@oracle.com>
 <62e1999b4121e_2d2079294ea@dwillia2-xfh.jf.intel.com.notmuch>
 <9ca37489-e7f6-f619-c9a7-a1d9665c477f@oracle.com>
 <62e2d9784bc58_37b17529451@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62e2d9784bc58_37b17529451@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 371eea93-d26f-4000-63e1-08da70d7e4ae
x-ms-traffictypediagnostic: CY5PR10MB5914:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qPQLUJX9bh30KaLfD9AQ59ej7PcmFc5OdBrxbyuQhC+5GNkskGaYN0cTMBtEvIpbkknn253gZKUH6MY4ST9EAlcPn5awX91Z110wFsj2fwG0UnIEinTcUTRFieDuNIsMQnBBOdZzHfrli3F4ih5OinYvc/K1cO2KkHYxd7AWghhvCeXBD4nzk9OYYbbWXBD9ovmI8frHifh8IPic610R0vqXOKrvcUnJ+dvK4f7d2AWyiFu7tDIdTOWv7puQl6ZlIjvw98q2HKR7jjTsezPCSZ+0O6jeYfkrGs8WPFG6l8yuNoXH2vgM0pXzaepy4Cw799Ad1Hfb5w4YaofbJBuGCBzW8AXd9Z619DcPRO6ZuPvVPwLGLrN5LTDNZkThRACzRgVuH3FhGG2efKxlueb/YiPt5go6wXLQpcb3lpnYQNcz0DY1bDTy7tGYik71cKGvEqQT0RxBCYtQslV/L/QR1O5Ek6hPI6FmgNSIVwEwxFlkrQ1MI01hWHW2BfLRmX63liNa6taYl4Sk2S60flYF3YDJmGh1UAqkzAlFR35iF0Rc9javq3bwO7pfHJgs4KPbIlCLOMz7RXcozDlLFheJgQfZT/BRwSknDaP0NhboTW8TEVSlkPbZIfv1bpu2GKcujrZjaJ7WwShevbU5oHl1KbNvvqm+EUPviAJOtWMMW57Pchv5xFt7+v+R+5xPb72Ef8pib3LFGcah8o1zABDAVz7WB3y2iCiiA1mWJNRCBrTMen3qxMM7dA77cMscXv+6xromytkAnZZZy/iZAOl21N4Ut9DQKhvwdwg8plkQTZOj8r10wArwbTmqwWSJho5gGtvTc7hyOz5jc5/MVSQAWWE/bdWPISAgML3v9ZxkePn56Xc/UafYFZ6UtgFd8gf45xN8qJLz7hhqrLUoCd+JTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(396003)(136003)(346002)(91956017)(66476007)(31696002)(44832011)(5660300002)(66446008)(8936002)(64756008)(76116006)(26005)(6512007)(316002)(7416002)(66946007)(6506007)(38070700005)(41300700001)(2906002)(66556008)(921005)(122000001)(53546011)(6486002)(966005)(38100700002)(71200400001)(110136005)(8676002)(31686004)(86362001)(186003)(2616005)(478600001)(83380400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3NHZTN4Y2k5S3h4VUhYRkVOWUxSWXhKWlFyUmkrbTE2bGhEbTdLZnphK1M5?=
 =?utf-8?B?MkRxUHhzaFkwaUg3Q0RsV2FHUHlWMnpsUk5QK1UxTzgvUjJ0U2NCQThRTEtn?=
 =?utf-8?B?KzNhc1AvRytzVHdObG9Ldlh0Tm9xeE5OT1hPMkQ1bmg3em90TTBYTkRCcXly?=
 =?utf-8?B?Wnhhb05rWWs2VDFVTmp6VXRLZXJqanRTNjNtYlFJQ05PNEtHczhWTEk2UXhI?=
 =?utf-8?B?VXBuTUlkS0NvRUNRcVN6ZlR2WjNuNkptWWZqNlMxK0YyeFJ1K1ZKc0xLQzA5?=
 =?utf-8?B?cWZ5Rmk3amNqaEFaWjZMRlNPc25KTngrS0prakZsOVB4SG11TmloYTNGamZO?=
 =?utf-8?B?ZUpHS1JTK1lNNUh5bVlwMGUzcWNEVE81Q0JoclJFeXhxcENqM1gyeTUvSXlw?=
 =?utf-8?B?bXpTQkMrc0dDeXFEclQ0TUNRVm40bS9BbDNIdVBkTjNLeUtzNUc0YWtSQjNp?=
 =?utf-8?B?TkF1M3JpMnpoWjdoaFJSRUVySDYvTkNWQXZOa2RiemRKdzgrVGg3VFE2Vi82?=
 =?utf-8?B?b0FKZ2hpejgzSHYwNzVlQmJxRmtldzBxZEhZOG00S2hnQi9VT04vM1BXRGJP?=
 =?utf-8?B?azU3eHpCVlo3blM4VmRSekRsZzh6dFV3MmdWdXNRb2VRYks5aHZlRmNNNi9x?=
 =?utf-8?B?TFV4SkE3emZMYzQxWU5LVTRsRnFDUkhiOEFVYmxvVE9JNjFTQmJ6OTVBUHpv?=
 =?utf-8?B?VWNEaWpIb3lDVTgyQm0wLzJxRXhGRVZ3UkpqVEwyMzlGWVVmenJuTjM3TW9G?=
 =?utf-8?B?dTNOYnFPLzNZV0RFU3VMN04wbGo0ajFpQ0tLbm8wc0k3cUFWM1ZaTENLRktP?=
 =?utf-8?B?cldRclhNeW9OU2R0UDlRbm1xeTZEVHRTV3BJVkpXTUE2Sm1uM0RQODk1Z3Fo?=
 =?utf-8?B?L3hlckM1c1NkK3J6UktHQTArTXZCdEIyaEYzcE0xYXh0dldINFJudm11NlhQ?=
 =?utf-8?B?QXpZYmdXRDJPKzZPNjhTQ3VFZURuRDA1VmF5NXl1SXNKK21RM0NUZ1V5L1Fz?=
 =?utf-8?B?WW5tUlNTdURZdHEweTJZQ1lPNXVmMTV3a3NYdnQ3V256ZHFmZTFzODYzaFNG?=
 =?utf-8?B?T3ZvVFhZazBhSmpQT3RURmVNRmI3d2k0eEVJOTRqaUYwYVZXVk5IUnpSeGdS?=
 =?utf-8?B?bTBDOUpmdTMvb2NXRE1vQjZqWmdjOU5Zc1pTYnRtUVdwaHJocW9DSnF0d3J3?=
 =?utf-8?B?ZC8ySHdXL0VVSVRWVm9WMmlNNXhIUzFKSWt5cGtIMDZyYk11enU2SmwxekZR?=
 =?utf-8?B?UFRyRDZVaHRyNVNNYXp0c3FGazV6bUxvN1JKODBwcm1NV3dlalQvSjEyNGNE?=
 =?utf-8?B?QmZ4TjAyVW1vSzFJTjYvQTVqVHRhdnMxYWJTdzdkc1ZqQXRmSGxkZVlvRCtE?=
 =?utf-8?B?WTNGMmhMaVVMbTZKZVBDUGEveEgwSnVLcjF4VnN3UzhZR2QzbDRRL3RBQlpF?=
 =?utf-8?B?U0xlNUhhSzRGZE0rRm1sTWpVRHNCeXFiWWdJdytaVldtbGI1ZVkrQklSVnp3?=
 =?utf-8?B?TmEydXhiWk9aNUJkQTk2Z2xocDdLY2p1YlZPMFh2YVRqZTlGWnV5c1loU2Vo?=
 =?utf-8?B?d0J3amNxakUzaGVPVXdvcEgyRFpaZjZtMm5zd2EvZTdhbTlWR2lrVGdLMHRm?=
 =?utf-8?B?bzZsbjBUVlFLczRZUHVhL1hxa1VrWlV0WUgwUFJtMUo2UVBUdVNMVnUyY05s?=
 =?utf-8?B?UjhuR29MM3dWVGFLcnhRd2J1ZzJYU2liY0tQbkd0a0d6NEM4V2szbWdUcHYr?=
 =?utf-8?B?OU1KV2szWjkveDlnUjVqa1JvUit5dlRvc2pWTG9NNUF6LzhOTTd5UDljYWpT?=
 =?utf-8?B?V1YyMFd4SENRMjUyV0FQS1M4ZXE4ZkxvaGpaQW05bkUrSlRlUDlBR2tMbXFY?=
 =?utf-8?B?K3k5YnY3T0NYQlY5MUk3T084UUg4ZXVQRDE4R1FWRHg1endBTm83V2Y3cVhJ?=
 =?utf-8?B?SG02R0ZkdElTZzQ2RXh4UzA4YjJhSktwc0RRR0I5TWp1M290VU9ZWGtKSm8x?=
 =?utf-8?B?UUlUa1UzZXJucGFSMEp3R1FQRXhHN2hUVGlHNE9KTWM5TXI3b0dGZWZLcHVj?=
 =?utf-8?B?QnQ4eHR5Q1ZGSzArN2JBQXhRZTlCUmdFeEwwa2FWSVRVQ2grY0VSZkh5V01j?=
 =?utf-8?Q?6iAk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F913C44865DDFA44AE41ECA60FEB8177@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371eea93-d26f-4000-63e1-08da70d7e4ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 20:29:38.2947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yng+bH+KbwaK9Rdj5jTZYlVDrAJtQOFnz88yKBYxzK2rAeCyBEq7o845Pwq3i+nu5YCp0PLfQG7a0FQFkXhlyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280093
X-Proofpoint-ORIG-GUID: UxC9GqDDSoBsMYTF0EeRU3LYOinZb5mc
X-Proofpoint-GUID: UxC9GqDDSoBsMYTF0EeRU3LYOinZb5mc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gNy8yOC8yMDIyIDExOjQ2IEFNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+IEphbmUgQ2h1IHdy
b3RlOg0KPj4gT24gNy8yNy8yMDIyIDE6MDEgUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4+PiBK
YW5lIENodSB3cm90ZToNCj4+Pj4gT24gNy8yNy8yMDIyIDEyOjMwIFBNLCBKYW5lIENodSB3cm90
ZToNCj4+Pj4+IE9uIDcvMjcvMjAyMiAxMjoyNCBQTSwgSmFuZSBDaHUgd3JvdGU6DQo+Pj4+Pj4g
T24gNy8yNy8yMDIyIDExOjU2IEFNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+Pj4+Pj4+IEphbmUg
Q2h1IHdyb3RlOg0KPj4+Pj4+Pj4gV2l0aCBDb21taXQgNzkxN2Y5Y2RiNTAzICgiYWNwaS9uZml0
OiByZWx5IG9uIG1jZS0+bWlzYyB0byBkZXRlcm1pbmUNCj4+Pj4+Pj4+IHBvaXNvbiBncmFudWxh
cml0eSIpIHRoYXQgY2hhbmdlZCBuZml0X2hhbmRsZV9tY2UoKSBjYWxsYmFjayB0byByZXBvcnQN
Cj4+Pj4+Pj4+IGJhZHJhbmdlIGFjY29yZGluZyB0byAxVUxMIDw8IE1DSV9NSVNDX0FERFJfTFNC
KG1jZS0+bWlzYyksIGl0J3MgYmVlbg0KPj4+Pj4+Pj4gZGlzY292ZXJlZCB0aGF0IHRoZSBtY2Ut
Pm1pc2MgTFNCIGZpZWxkIGlzIDB4MTAwMCBieXRlcywgaGVuY2UNCj4+Pj4+Pj4+IGluamVjdGlu
Zw0KPj4+Pj4+Pj4gMiBiYWNrLXRvLWJhY2sgcG9pc29ucyBhbmQgdGhlIGRyaXZlciBlbmRzIHVw
IGxvZ2dpbmcgOCBiYWRibG9ja3MsDQo+Pj4+Pj4+PiBiZWNhdXNlIDB4MTAwMCBieXRlcyBpcyA4
IDUxMi1ieXRlLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IERhbiBXaWxsaWFtcyBub3RpY2VkIHRoYXQg
YXBlaV9tY2VfcmVwb3J0X21lbV9lcnJvcigpIGhhcmRjb2RlDQo+Pj4+Pj4+PiB0aGUgTFNCIGZp
ZWxkIHRvIFBBR0VfU0hJRlQgaW5zdGVhZCBvZiBjb25zdWx0aW5nIHRoZSBpbnB1dA0KPj4+Pj4+
Pj4gc3RydWN0IGNwZXJfc2VjX21lbV9lcnIgcmVjb3JkLsKgIFNvIGNoYW5nZSB0byByZWx5IG9u
IGhhcmR3YXJlIHdoZW5ldmVyDQo+Pj4+Pj4+PiBzdXBwb3J0IGlzIGF2YWlsYWJsZS4NCj4+Pj4+
Pj4+DQo+Pj4+Pj4+PiBMaW5rOg0KPj4+Pj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci83
ZWQ1MGZkOC01MjFlLWNhZGUtNzdiMS03MzhiOGJmYjg1MDJAb3JhY2xlLmNvbQ0KPj4+Pj4+Pj4N
Cj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBSZXZpZXdlZC1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxs
aWFtc0BpbnRlbC5jb20+DQo+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKYW5lIENodSA8amFuZS5j
aHVAb3JhY2xlLmNvbT4NCj4+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pj4gICDCoCBhcmNoL3g4Ni9rZXJu
ZWwvY3B1L21jZS9hcGVpLmMgfCAxNCArKysrKysrKysrKysrLQ0KPj4+Pj4+Pj4gICDCoCAxIGZp
bGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pj4+Pj4NCj4+
Pj4+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMNCj4+Pj4+
Pj4+IGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvYXBlaS5jDQo+Pj4+Pj4+PiBpbmRleCA3MTcx
OTI5MTVmMjguLjI2ZDYzODE4YjJkZSAxMDA2NDQNCj4+Pj4+Pj4+IC0tLSBhL2FyY2gveDg2L2tl
cm5lbC9jcHUvbWNlL2FwZWkuYw0KPj4+Pj4+Pj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9t
Y2UvYXBlaS5jDQo+Pj4+Pj4+PiBAQCAtMjksMTUgKzI5LDI3IEBADQo+Pj4+Pj4+PiAgIMKgIHZv
aWQgYXBlaV9tY2VfcmVwb3J0X21lbV9lcnJvcihpbnQgc2V2ZXJpdHksIHN0cnVjdA0KPj4+Pj4+
Pj4gY3Blcl9zZWNfbWVtX2VyciAqbWVtX2VycikNCj4+Pj4+Pj4+ICAgwqAgew0KPj4+Pj4+Pj4g
ICDCoMKgwqDCoMKgIHN0cnVjdCBtY2UgbTsNCj4+Pj4+Pj4+ICvCoMKgwqAgaW50IGdyYWluID0g
UEFHRV9TSElGVDsNCj4+Pj4+Pj4+ICAgwqDCoMKgwqDCoCBpZiAoIShtZW1fZXJyLT52YWxpZGF0
aW9uX2JpdHMgJiBDUEVSX01FTV9WQUxJRF9QQSkpDQo+Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm47DQo+Pj4+Pj4+PiArwqDCoMKgIC8qDQo+Pj4+Pj4+PiArwqDCoMKgwqAgKiBF
dmVuIGlmIHRoZSAtPnZhbGlkYXRpb25fYml0cyBhcmUgc2V0IGZvciBhZGRyZXNzIG1hc2ssDQo+
Pj4+Pj4+PiArwqDCoMKgwqAgKiB0byBiZSBleHRyYSBzYWZlLCBjaGVjayBhbmQgcmVqZWN0IGFu
IGVycm9yIHJhZGl1cyAnMCcsDQo+Pj4+Pj4+PiArwqDCoMKgwqAgKiBhbmQgZmFsbGJhY2sgdG8g
dGhlIGRlZmF1bHQgcGFnZSBzaXplLg0KPj4+Pj4+Pj4gK8KgwqDCoMKgICovDQo+Pj4+Pj4+PiAr
wqDCoMKgIGlmIChtZW1fZXJyLT52YWxpZGF0aW9uX2JpdHMgJiBDUEVSX01FTV9WQUxJRF9QQV9N
QVNLKSB7DQo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgZ3JhaW4gPSB+bWVtX2Vyci0+cGh5c2lj
YWxfYWRkcl9tYXNrICsgMTsNCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZ3JhaW4gPT0g
MSkNCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdyYWluID0gUEFHRV9TSElGVDsN
Cj4+Pj4+Pj4NCj4+Pj4+Pj4gV2FpdCwgaWYgQGdyYWluIGlzIHRoZSBudW1iZXIgb2YgYml0cyB0
byBtYXNrIG9mZiB0aGUgYWRkcmVzcywgc2hvdWxkbid0DQo+Pj4+Pj4+IHRoaXMgYmUgc29tZXRo
aW5nIGxpa2U6DQo+Pj4+Pj4+DQo+Pj4+Pj4+ICAgwqDCoMKgwqAgZ3JhaW4gPSBtaW5fbm90X3pl
cm8oUEFHRV9TSElGVCwNCj4+Pj4+Pj4gaHdlaWdodDY0KH5tZW1fZXJyLT5waHlzaWNhbF9hZGRy
X21hc2spKTsNCj4+Pj4+Pg0KPj4+Pj4+IEkgc2VlLiBJIGd1ZXNzIHdoYXQgeW91IG1lYW50IGlz
DQo+Pj4+Pj4gICDCoMKgwqAgZ3JhaW4gPSBtaW4oUEFHRV9TSElGVCwgKDEgKw0KPj4+Pj4+IGh3
ZWlnaHQ2NCh+bWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNrKSkpOw0KPj4+Pj4NCj4+Pj4+IFNv
cnJ5LCB0YWtlIHRoYXQgYmFjaywgaXQgd29uJ3Qgd29yayBlaXRoZXIuDQo+Pj4+DQo+Pj4+IFRo
aXMgd2lsbCB3b3JrLA0KPj4+PiAgICAgIGdyYWluID0gbWluX25vdF96ZXJvKFBBR0VfU0hJRlQg
LSAxLA0KPj4+PiBod2VpZ2h0NjQofm1lbV9lcnItPnBoeXNpY2FsX2FkZHJfbWFzaykpOw0KPj4+
PiAgICAgIGdyYWluKys7DQo+Pj4+IGJ1dCB0b28gc29waGlzdGljYXRlZD8gIEkgZ3Vlc3MgSSBw
cmVmZXIgdGhlIHNpbXBsZSAiaWYiIGV4cHJlc3Npb24uDQo+Pj4NCj4+PiBBbiAiaWYiIGlzIGZp
bmUsIEkgd2FzIG1vcmUgcG9pbnRpbmcgb3V0IHRoYXQ6DQo+Pj4NCj4+PiAgICAgICBod2VpZ2h0
NjQofm1lbV9lcnItPnBoeXNpY2FsX2FkZHJfbWFzaykgKyAxDQo+Pj4NCj4+PiAuLi5hbmQ6DQo+
Pj4NCj4+PiAgICAgICB+bWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNrICsgMTsNCj4+Pg0KPj4+
IC4uLmdpdmUgZGlmZmVyZW50IHJlc3VsdHMuDQo+Pg0KPj4gVGhleSBhcmUgZGlmZmVyZW50IGlu
ZGVlZC4gIGh3ZWlnaHQ2NCByZXR1cm5zIHRoZSBjb3VudCBvZiBzZXQgYml0IHdoaWxlDQo+PiB+
bWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNrIHJldHVybnMgYSBuZWdhdGVkIHZhbHVlLg0KPj4N
Cj4+IEFjY29yZGluZyB0byB0aGUgZGVmaW5pdGlvbiBvZiAiUGh5c2ljYWwgQWRkcmVzcyBNYXNr
IiAtDQo+Pg0KPj4gaHR0cHM6Ly91ZWZpLm9yZy9zaXRlcy9kZWZhdWx0L2ZpbGVzL3Jlc291cmNl
cy9VRUZJX1NwZWNfMl85XzIwMjFfMDNfMTgucGRmDQo+Pg0KPj4gVGFibGUgTi0zMSBNZW1vcnkg
RXJyb3IgUmVjb3JkDQo+Pg0KPj4gUGh5c2ljYWwgQWRkcmVzcyBNYXNrIDI0IDggICBEZWZpbmVz
IHRoZSB2YWxpZCBhZGRyZXNzIGJpdHMgaW4gdGhlDQo+PiBQaHlzaWNhbCBBZGRyZXNzIGZpZWxk
LiBUaGUgbWFzayBzcGVjaWZpZXMgdGhlIGdyYW51bGFyaXR5IG9mIHRoZQ0KPj4gcGh5c2ljYWwg
YWRkcmVzcyB3aGljaCBpcyBkZXBlbmRlbnQgb24gdGhlIGh3LyBpbXBsZW1lbnRhdGlvbiBmYWN0
b3JzDQo+PiBzdWNoIGFzIGludGVybGVhdmluZy4NCj4+DQo+PiBJdCBhcHBlYXJzIHRoYXQgIlBo
eXNpY2FsIEFkZHJlc3MgTWFzayIgaXMgZGVmaW5lZCBtb3JlIGxpa2UgUEFHRV9NQVNLDQo+PiBy
YXRoZXIgdGhhbiBpbiBiaXRvcHMgaHdlaWdodDY0KCkgb2Z0ZXIgdXNlZCB0byBjb3VudCB0aGUg
c2V0IGJpdHMgYXMNCj4+IGFuIGluZGljYXRpb24gb2YgKGUuZy4pIGhvdyBtYW55IHJlZ2lzdGVy
cyBhcmUgaW4gdXNlLg0KPj4NCj4+IEFucyBzaW1pbGFyIHRvIFBBR0VfTUFTSywgYSB2YWxpZCAi
UGh5c2ljYWwgQWRkcmVzcyBNYXNrIiBzaG91bGQNCj4+IGNvbnNpc3Qgb2YgYSBjb250aWd1b3Vz
IGxvdyAwIGJpdHMsIG5vdCAxJ3MgYW5kIDAncyBtaXhlZCB1cC4NCj4+DQo+PiBTbyBmYXIsIGFz
IGZhciBhcyBJIGNhbiBzZWUsIHRoZSB2NCBwYXRjaCBzdGlsbCBsb29rcyBjb3JyZWN0IHRvIG1l
Lg0KPj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEknbSBtaXNzaW5nIGFueXRoaW5nLg0KPiANCj4g
VGhlIHY0IHBhdGNoIGxvb2tzIGJyb2tlbiB0byBtZS4gSWYgdGhlIGFkZHJlc3MgbWFzayBpcw0K
PiAweGZmZmZmZmZmZmZmZmZmYzAgdG8gaW5kaWNhdGUgYSBjYWNoZWxpbmUgZXJyb3IgdGhlbjoN
Cj4gDQo+ICAgICAgfm1lbV9lcnItPnBoeXNpY2FsX2FkZHJfbWFzayArIDE7DQo+IA0KPiAuLi5y
ZXN1bHRzIGluIGEgZ3JhaW4gb2YgNjQgd2hlbiBpdCBzaG91bGQgYmUgNi4NCg0KUmlnaHQsIGl0
J3MgdGhlIGV4cG9uZW50IHRoYXQncyBuZWVkZWQsIHNvIGJhY2sgdG8gX19mZnM2NCgpLg0KU29y
cnkgZm9yIHRoZSBkZXRvdXIuICB2NSBpcyBjb21pbmcgbmV4dC4NCg0KdGhhbmtzIQ0KLWphbmUN
Cg==
