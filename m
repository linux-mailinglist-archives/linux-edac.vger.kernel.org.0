Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D985A587260
	for <lists+linux-edac@lfdr.de>; Mon,  1 Aug 2022 22:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiHAUek (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Aug 2022 16:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiHAUej (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 1 Aug 2022 16:34:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5932B62A;
        Mon,  1 Aug 2022 13:34:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271KSlJF023128;
        Mon, 1 Aug 2022 20:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QCK2TgUeOK45EAMpjO66m4Tblzy6TUaXNLnplAks2FM=;
 b=mQARlsrPuuZe236RRxSDZP16RJW1u0JKDGyADqKfm2Ug8f+aEa6SzxrSay5HF1VJtJtP
 DfKc1WieY30RgMN2ACE6cEZv5TM+iuXePHeuvRkao8ae86SjUo48JpXFbF29HZy1dcny
 RofUlETdF5YmsWTghSAtHNHhpm7nfjZsO6ia8phrbYkUC/ODyOGCC0mdA131Qk3Fr3rz
 IemXnAvPNj4sg4TQgOO0d1NTjq54A/f6n2NIB1J7OPF+d1VUn0LSpmL2MVgNx2pACKLk
 BubW1vBbNI9zjfnUgeOyOl0Qr/vE29/6KRz+AufHzSslza9BXe4wierWX6gZotqPUUAh Eg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80vwnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 20:34:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271Jb2qC007532;
        Mon, 1 Aug 2022 20:34:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu31dv5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 20:34:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS5WAkUUO9H3BCesRdP7UjSL/A1qUKXoQLpiuHTRQyb3EbGG/7rX6I2xQtA0GhFqi/8XNLNIxM4jJv5rMwa2cUjRX7OnWBKmATSoMnrlpWE3KkAcPE3aNZtg5CLaNWf7fBwyGfTX+fx0xVdjsRpmr28BTve0Vir7VFBZD5y+IOQ9Sn4y4eiUjaJkSi4JpNmeeEgtzlGvRb85r99w3RLi+/OMdZSlzCU79XFZiejOqpQLzFZnjuzBeAJhjZZetF2uD0N/s9INbY7FHam77Ogp5QSDQLLvH0sCsckfPRryHR7QLl0bi7JkDOmONTcVOqoAPxtL9zRIdZgWtVFkV3/K4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCK2TgUeOK45EAMpjO66m4Tblzy6TUaXNLnplAks2FM=;
 b=G/Sd1z+fkLlW5khCX8OKfeH7wx7BeqUXVz9ET6HdEK0dhOZUtvMA5Va1almMhE6kw3ZP2JTXoYDjVg4JTbJ046b+2uvyJCdI4cYylpPPmrOw54rOBX9nlAZaD+bz2ByRInUEMYjQ980Bjq5aQsLEiCLUsL2JE5KSzOsrxW5q6pqMxjLPkQwEoDvIx6RfTYdz3Af+hlMSDclA/aFshLjDigX9tqcjvrkktUYJU+reti9pFCoHA1k4uSHb8ELR5vkKHrb6fHAnm9aX0sazMzKZS1a0CZj/40S04cuysnOuTexihJEVx9cv4T3tBX3euYb7zvj4kB6JfaJaQ2KwLUs3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCK2TgUeOK45EAMpjO66m4Tblzy6TUaXNLnplAks2FM=;
 b=kLIEGWFaikE9xipp7DmXk69XRuCs/ZSsZ4OxLtG0Erut14Gq8gRSkAtGqcFTi+tQeBNw96NvtqU2DVd7L4NqQnkkgAXTkUIErw4gYBtcKuAl4cmIESD0hAqw854nXF0OH4bWfmEhM0PaHqyuwkldZ8OPTF3ia/2PkNHIoW6LAys=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BN8PR10MB3203.namprd10.prod.outlook.com (2603:10b6:408:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Mon, 1 Aug
 2022 20:34:07 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 20:34:07 +0000
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
Subject: Re: [PATCH v5] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v5] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYo9wls6kiGpcxYkOd5j6I+plua62aREeAgABAFwA=
Date:   Mon, 1 Aug 2022 20:34:07 +0000
Message-ID: <e3234907-df27-f0d4-ef63-ee1ec9808f54@oracle.com>
References: <20220730061757.3441537-1-jane.chu@oracle.com>
 <62e802fb22f2f_b075294a8@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62e802fb22f2f_b075294a8@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a45898c6-3aa8-49cf-5e5e-08da73fd2eb3
x-ms-traffictypediagnostic: BN8PR10MB3203:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sl2ILov/tgKMiFhfjrN5i+vFfN5IbOogOUZr7W1weMTqlZKfMZMtpUdEDn9EqeCu0cTc2U3udFB+g0hTWb6QOqIATfZjmcWUJxggH1XQls1BjcBl+vUb6fZhpKLBfidvHwnC0oaJjtpvkV0jawe0GcF++GHhbyV4SW2zWGAbrS0q9YX9K5z+hOCoJ6pPBIzd1ZYhOFgjs2Y84gp3lzVel/eOmWca6I5VE7vm0+vLtj/CprWDEhtZbp9t/0lQUhrVhvZrL8vLqtZmgbWipB8Nj7K7CMx3dMhdI6bPW6SFVl6+KWcE/JDc588/HBQt6/IbOj4+zbmSBg7epiBp0raPflSnOSRHDWUcwY61ApzG+RV7VTRQZy8R88Co00uR+5yhWGeYnxb/BrnEIuoQ+wbdvz4tINIPIXoRzobevWng6lvdd92G1Ti5sxErPrn+BKl7uWS4RApqEQh7M7jfDaIA2j0KrQ6wjM6meaxFlJYKpfm+VmKh/XHFUamXD4Z+wgw9H3s6lgLH0B6SqT4nPSU2OMQrtFeQyEaDV4tgSErVUJYSaKlwrYoSJt16mcGl74WT4tTFeYmj3xDb9etXrE9kmt4o3TzTes0QQn70RX4jEQzAwd4xDMgfRKBRQL/Uv/li9OVdgRaMwesPvgoLFAnbJD4zzqu4qsAV1iTdJN8/RnkEJoiXRS7p2tIdYnS+UrA2gIWR1S1gU5fWMdr7qMjyw9uJiRkSj3pNcTcALFjtHw21f+Qt0INPiopvR/bv6h8RlnHhnaQvGSulkkQYhx4Iaf399pLVguNfciyzvmw1zKEC9LLcYwGDj+U0z0tSY5+mKB4KUAdENewRceU5/meaEKRXBIjGZCL/q4rhNfoCyuHhohuRGzt+vDVUGAYm6zd1UWvJZseez3VDmj1A77tuu5Cs5JGG2SECBwWr6g8Vuz0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(346002)(366004)(376002)(921005)(122000001)(38100700002)(31686004)(5660300002)(31696002)(36756003)(86362001)(38070700005)(44832011)(7416002)(2906002)(66556008)(966005)(6506007)(8936002)(478600001)(66946007)(53546011)(66476007)(66446008)(64756008)(26005)(6512007)(83380400001)(110136005)(71200400001)(8676002)(76116006)(6486002)(41300700001)(316002)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cS9NWllLcEt5ajZpOExXU3lzKzF1Y09OeXUwNGFyeUxDcEhFK2x5ZmUvTjVz?=
 =?utf-8?B?UXlUNDNOVjFHYmR4Y3duQ3dzK0wwUHA0dkVQaVRDMENrSmpibmZSRXhwQXRu?=
 =?utf-8?B?K1dkM3NTUU51bFFtOUp0SDE5Q3BnRkxwUm43RTJCeGpoTENyNTMyTHpQQ2Er?=
 =?utf-8?B?SzgwWjNmUExRRUcxeVRTT0VFTnUxNzNTSnFtR0kwTVdMU2VZRkt1SnA3d0py?=
 =?utf-8?B?T0Zuc05lZ3B6Nm1FQWtWUnZsRXAyYldqOE43a0l2TlJuSGF1bkQzb0krYVNk?=
 =?utf-8?B?ekkxNHluSGJuMWlNVzMzZFI4dXpXMDV1UVB1K2wxNE15cjhwYlBrYnAreUdm?=
 =?utf-8?B?REJ2eEJTcFoxNnh3ck5hYUUyUFlpeW5QK1FHb1NGbjJrZWgrY3JQd25KczY3?=
 =?utf-8?B?L0NES1pRSlViRU03SEZidzV3Q3hBVzlXYXlla2pMSjZoM2o5blpIYWkyMitK?=
 =?utf-8?B?VFVjb0ZHYWRuNHI3bXVWc0VyNHdEYzEvRlpMRUNhVllIUXpHem1rUEkraUUv?=
 =?utf-8?B?SWFkK3d2Z2VYRER4T01xdjFvaXdYaGNhZ1lYMy9ORnJJUzBvNy9rNm1MNWJr?=
 =?utf-8?B?bEE5MG1uV0NFaldvUi90Mng1dFFMWU5SWUJsY2NBdmxVMlZMZVAzb0F0aXMv?=
 =?utf-8?B?QUdMRGhQQzlFS1g5S0NLQXZSdy9oSXhnemtvZWJNdHV6VlMwSldxTmgycmxk?=
 =?utf-8?B?NXN3VGhnWWRrV3phODF2Y0ZUSVMwSWc0dlZ5bXU4MVZMSUY1U2Z0N2NkdjBr?=
 =?utf-8?B?MTlvY2xGekVaZGxEc0x5bkNzQXhOWEswM3NDc0NuN1d0TkFiWWdRVXRISTFs?=
 =?utf-8?B?Z3kvVHpiMkl1N2JiZXpRNnQyTmM4d3ZBcEIzYTd6MkVUZDRKSWJONEtKbVA2?=
 =?utf-8?B?d3pUUDJhR2ZaenNzTFp2OGY1TkxYT1V6RnlHTmQ5R3NKQ21WQkpKd205WUda?=
 =?utf-8?B?QVBUQSt5dWRwWmpOUFNRM3l3ay9DSmUzeXdQR0Zxalc0czZ2Nm9FWE1QL2VO?=
 =?utf-8?B?U3B2MkxlMGVYaHNOSnJVNzEvbzJwNmdSeXRsNmdTUGJnSVFuRVZaL0plZi9Z?=
 =?utf-8?B?bHVrd3A5SEE5SzdycDFWRlhFRzM3WGF3eHJZS0pwWEtza1h2dzg1Z0hzTzZx?=
 =?utf-8?B?NzF2bEJVRXNWRkk4VVZsYUJqS1M4RGJ4dTR1SEVZeHdqTldGYjR4S0N4bTNC?=
 =?utf-8?B?a0Zvbk0zKzIwRUxVUDFEcHRmMWhhbjBCN3dkbEtLanJNMi9TaC9xcGtXcEtS?=
 =?utf-8?B?c3UrRUpuMWVubUkvZmxXNXo1RHlPT0xVS3VhQ3pWNThFdnZSTS9BQnJ5NXUr?=
 =?utf-8?B?V2svbkdOQzYxRktNaDRYSUsvaDd1STd0c3ovYWw5S2ZaWWdMNjNTT0k5eGxa?=
 =?utf-8?B?anUwUDB5enYrR2hKY0V4TWhaSGtFNjBEU3ZqU3JoTzJUS2NWemN2M3hjU0Fp?=
 =?utf-8?B?SGZLaWpvSzBHNWx6b1FlSGx6eGoxekFJVXZ6cWsyWFBmNlJOcWRXZ004S1k5?=
 =?utf-8?B?SUR2ekJUK3dRU3hjMVc5ZVJMcXFQNlpKNlpsUEZCc3FRQzF4QTUrelczTkc4?=
 =?utf-8?B?THdaL0tNRndaeldYTHRMZysxV2htc2ZMZDlDUDd5YU4wY2w0Nkd1cDdERVdt?=
 =?utf-8?B?VUZ4WnZHTE5PWXh2bGpobUNGcnNpS1VIOGxQbXNmRWU5TkZNR3h0OGpNaVlo?=
 =?utf-8?B?aE1oTmptVUV2OFFLbG5rZ2xLNWtkWVdqMHo5Sk9xZE1GTVhydFdjNEtKZ0sy?=
 =?utf-8?B?emlJYjVqSkFza0pNYjdmSkFqdkZPSGxCSlRPZHAxbmtSYzg0cy8yMDNPRE5V?=
 =?utf-8?B?YzBkcE0vN3NNdlZSQ0FGeUpXdkZXN0RsUGt0S3FNWVAzek5ORnRLOHViYmhE?=
 =?utf-8?B?R1F3ZHh5ZU5XUitiMHdmc0k5UEtBWFIxSUExUXc4Y0wwbCtkKy82N1dNcGRl?=
 =?utf-8?B?ZWtPUS9HRzRkTEFzNlc2N3hMNFY0bng2ZGtGUVE1VCtMb1NzakJNcWFRUXBq?=
 =?utf-8?B?ZUFqNm5iVTN1dWtpVHFCNkp6Z1hWN2dpemRZWUpSa3NSQUc4eDNDYVBQUjBR?=
 =?utf-8?B?Wm55dE8zbFdObGJXMWlVa2FuT3N5WDNsVFVPbUxIUy9TaTVFZlhLK2kxLy95?=
 =?utf-8?Q?9MJw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <487FE2B04A0C9C48A675E478933A819B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45898c6-3aa8-49cf-5e5e-08da73fd2eb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 20:34:07.3304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFKFLF5khtDwpgaiPDL4m9tggbwsOVncMDoicJIpi4B5hE9DTsEnaHc4Mx3ohwWVPutGSG8FhlaR2g4XqOxAnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010102
X-Proofpoint-ORIG-GUID: ENWQLkznZGhnpfXPwpIrsPyVQmla9ufs
X-Proofpoint-GUID: ENWQLkznZGhnpfXPwpIrsPyVQmla9ufs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gOC8xLzIwMjIgOTo0NCBBTSwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiBKYW5lIENodSB3cm90
ZToNCj4+IFdpdGggQ29tbWl0IDc5MTdmOWNkYjUwMyAoImFjcGkvbmZpdDogcmVseSBvbiBtY2Ut
Pm1pc2MgdG8gZGV0ZXJtaW5lDQo+PiBwb2lzb24gZ3JhbnVsYXJpdHkiKSB0aGF0IGNoYW5nZWQg
bmZpdF9oYW5kbGVfbWNlKCkgY2FsbGJhY2sgdG8gcmVwb3J0DQo+PiBiYWRyYW5nZSBhY2NvcmRp
bmcgdG8gMVVMTCA8PCBNQ0lfTUlTQ19BRERSX0xTQihtY2UtPm1pc2MpLCBpdCdzIGJlZW4NCj4+
IGRpc2NvdmVyZWQgdGhhdCB0aGUgbWNlLT5taXNjIExTQiBmaWVsZCBpcyAweDEwMDAgYnl0ZXMs
IGhlbmNlIGluamVjdGluZw0KPj4gMiBiYWNrLXRvLWJhY2sgcG9pc29ucyBhbmQgdGhlIGRyaXZl
ciBlbmRzIHVwIGxvZ2dpbmcgOCBiYWRibG9ja3MsDQo+PiBiZWNhdXNlIDB4MTAwMCBieXRlcyBp
cyA4IDUxMi1ieXRlLg0KPj4NCj4+IERhbiBXaWxsaWFtcyBub3RpY2VkIHRoYXQgYXBlaV9tY2Vf
cmVwb3J0X21lbV9lcnJvcigpIGhhcmRjb2RlDQo+PiB0aGUgTFNCIGZpZWxkIHRvIFBBR0VfU0hJ
RlQgaW5zdGVhZCBvZiBjb25zdWx0aW5nIHRoZSBpbnB1dA0KPj4gc3RydWN0IGNwZXJfc2VjX21l
bV9lcnIgcmVjb3JkLiAgU28gY2hhbmdlIHRvIHJlbHkgb24gaGFyZHdhcmUgd2hlbmV2ZXINCj4+
IHN1cHBvcnQgaXMgYXZhaWxhYmxlLg0KPj4NCj4+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3IvN2VkNTBmZDgtNTIxZS1jYWRlLTc3YjEtNzM4YjhiZmI4NTAyQG9yYWNsZS5jb20NCj4+
DQo+PiBSZXZpZXdlZC1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBKYW5lIENodSA8amFuZS5jaHVAb3JhY2xlLmNvbT4NCj4+IC0t
LQ0KPj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMgfCAxNCArKysrKysrKysrKysr
LQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMNCj4+IGluZGV4IDcxNzE5MjkxNWYyOC4uMmM3ZWEw
YmE5ZGQ3IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvYXBlaS5jDQo+
PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMNCj4+IEBAIC0yOSwxNSArMjks
MjcgQEANCj4+ICAgdm9pZCBhcGVpX21jZV9yZXBvcnRfbWVtX2Vycm9yKGludCBzZXZlcml0eSwg
c3RydWN0IGNwZXJfc2VjX21lbV9lcnIgKm1lbV9lcnIpDQo+PiAgIHsNCj4+ICAgCXN0cnVjdCBt
Y2UgbTsNCj4+ICsJaW50IGxzYiA9IFBBR0VfU0hJRlQ7DQo+PiAgIA0KPj4gICAJaWYgKCEobWVt
X2Vyci0+dmFsaWRhdGlvbl9iaXRzICYgQ1BFUl9NRU1fVkFMSURfUEEpKQ0KPj4gICAJCXJldHVy
bjsNCj4+ICAgDQo+PiArCS8qDQo+PiArCSAqIEV2ZW4gaWYgdGhlIC0+dmFsaWRhdGlvbl9iaXRz
IGFyZSBzZXQgZm9yIGFkZHJlc3MgbWFzaywNCj4+ICsJICogdG8gYmUgZXh0cmEgc2FmZSwgY2hl
Y2sgYW5kIHJlamVjdCBhbiBlcnJvciByYWRpdXMgJzAnLA0KPj4gKwkgKiBhbmQgZmFsbGJhY2sg
dG8gdGhlIGRlZmF1bHQgcGFnZSBzaXplLg0KPj4gKwkgKi8NCj4+ICsJaWYgKG1lbV9lcnItPnZh
bGlkYXRpb25fYml0cyAmIENQRVJfTUVNX1ZBTElEX1BBX01BU0spIHsNCj4+ICsJCWxzYiA9IF9f
ZmZzNjQobWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNrKTsNCj4+ICsJCWlmIChsc2IgPT0gMSkN
Cj4gDQo+IFRoaXMgd2FzIHRoZSByZWFzb24gSSByZWNvbW1lbmRlZCBod2VpZ2h0NjQgYW5kIG1p
bl9ub3RfemVybygpIGFzDQo+IGh3ZWlnaHQ2NCBkb2VzIG5vdCBoYXZlIHRoZSB1bmRlZmluZWQg
YmVoYXZpb3IuIEhvd2V2ZXIsIGFuIGV2ZW4gYmV0dGVyDQo+IG9wdGlvbiBpcyB0byBqdXN0IGRv
Og0KPiANCj4gICAgICBmaW5kX2ZpcnN0X2JpdCgmbWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNr
LCBQQUdFX1NISUZUKQ0KPiANCj4gLi4uYXMgdGhhdCB0cmltcyB0aGUgcmVzdWx0IHRvIHRoZSBQ
QUdFX1NISUZUIG1heCBhbmQgaGFuZGxlcyB0aGUgemVybw0KPiBjYXNlLg0KDQpUaGFua3MgRGFu
ISAgSG93ZXZlciBpdCBsb29rcyBsaWtlIGZpbmRfZmlyc3RfYml0KCkgY291bGQgY2FsbCBpbnRv
IA0KX19mZnMoeCkgd2hpY2ggaGFzIHRoZSBzYW1lIGxpbWl0YXRpb24gYXMgX19mZnM2NCh4KSwg
YXMgVG9ueSBwb2ludGVkIG91dC4NCg0KSSdsbCBwb3N0IHY2IHNob3J0bHkuDQoNCnRoYW5rcywN
Ci1qYW5lDQo=
